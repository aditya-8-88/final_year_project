import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/constants.dart';

class SosContact {
  final String id;
  final String name;
  final String phone;

  const SosContact({
    required this.id,
    required this.name,
    required this.phone,
  });

  Map<String, String> toMap() => {'id': id, 'name': name, 'phone': phone};

  factory SosContact.fromMap(Map<String, dynamic> map) => SosContact(
        id: map['id'] as String,
        name: map['name'] as String,
        phone: map['phone'] as String,
      );
}

class SosService {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get _p async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // ── Contacts ──────────────────────────────────────────────────────────────

  static Future<List<SosContact>> getContacts() async {
    final prefs = await _p;
    final raw = prefs.getStringList(AppConstants.sosContactsKey) ?? [];
    return raw
        .map((j) => SosContact.fromMap(
            Map<String, dynamic>.from(jsonDecode(j) as Map)))
        .toList();
  }

  static Future<void> addContact(SosContact contact) async {
    final prefs = await _p;
    final contacts = await getContacts();
    contacts.add(contact);
    await prefs.setStringList(
      AppConstants.sosContactsKey,
      contacts.map((c) => jsonEncode(c.toMap())).toList(),
    );
  }

  static Future<void> removeContact(String id) async {
    final prefs = await _p;
    final contacts = await getContacts();
    contacts.removeWhere((c) => c.id == id);
    await prefs.setStringList(
      AppConstants.sosContactsKey,
      contacts.map((c) => jsonEncode(c.toMap())).toList(),
    );
  }

  // ── Custom message ─────────────────────────────────────────────────────────

  static Future<String> getMessage() async {
    final prefs = await _p;
    return prefs.getString(AppConstants.sosMessageKey) ??
        AppConstants.sosDefaultMessage;
  }

  static Future<void> saveMessage(String message) async {
    final prefs = await _p;
    await prefs.setString(AppConstants.sosMessageKey, message);
  }

  // ── Launch SMS ─────────────────────────────────────────────────────────────
  //
  // On Android this opens the default SMS app with all emergency contacts
  // pre-filled as recipients and the SOS message in the body.
  // The user taps Send once — no SEND_SMS permission required.
  //
  // On web/desktop the method shows a graceful "not supported" result.

  static Future<SosLaunchResult> sendSos() async {
    if (kIsWeb) return SosLaunchResult.notSupported;

    final contacts = await getContacts();
    if (contacts.isEmpty) return SosLaunchResult.noContacts;

    final message = await getMessage();

    // sms: URI with comma-separated numbers works on Android
    final numbers = contacts.map((c) => c.phone).join(',');
    final uri = Uri(
      scheme: 'sms',
      path: numbers,
      queryParameters: {'body': message},
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        return SosLaunchResult.success;
      }
      // Fallback: try smsto: scheme
      final fallback = Uri.parse('smsto:$numbers?body=${Uri.encodeComponent(message)}');
      if (await canLaunchUrl(fallback)) {
        await launchUrl(fallback);
        return SosLaunchResult.success;
      }
      return SosLaunchResult.appNotFound;
    } catch (_) {
      return SosLaunchResult.appNotFound;
    }
  }
}

enum SosLaunchResult {
  success,
  noContacts,
  appNotFound,
  notSupported,
}

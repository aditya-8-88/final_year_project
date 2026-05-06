import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/constants.dart';
import 'location_helper.dart' as location;

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

  // ── Platform channel for direct SMS (native Android) ─────────────────────

  static const _smsChannel = MethodChannel('com.glbitm.women_safety_app/sms');

  /// Check if SEND_SMS permission is granted (native only).
  static Future<bool> hasSmsPermission() async {
    if (kIsWeb) return false;
    try {
      final granted = await _smsChannel.invokeMethod<bool>('checkSmsPermission');
      return granted ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Request SEND_SMS permission (native only). Returns true if already granted.
  static Future<bool> requestSmsPermission() async {
    if (kIsWeb) return false;
    try {
      final result = await _smsChannel.invokeMethod<bool>('requestSmsPermission');
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  // ── Send SOS ───────────────────────────────────────────────────────────────
  //
  // On native Android with SEND_SMS permission: sends SMS directly in background
  // to all emergency contacts — no user interaction needed after tapping SOS.
  //
  // On web (mobile browsers): opens sms: URI (user taps Send once).
  //
  // Fallback: if permission denied on native, opens SMS app like before.

  static Future<SosLaunchResult> sendSos() async {
    final contacts = await getContacts();
    if (contacts.isEmpty) return SosLaunchResult.noContacts;

    // Get saved message and try to append live location
    var message = await getMessage();
    final locationStr = await location.getLocationString();
    if (locationStr != null) {
      message += locationStr;
    }

    final numbers = contacts.map((c) => c.phone).toList();

    // ── Web path: open sms: URI in mobile browser ──
    if (kIsWeb) {
      try {
        final uri = Uri.parse('sms:${numbers.join(',')}?body=${Uri.encodeComponent(message)}');
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return SosLaunchResult.success;
      } catch (_) {
        return SosLaunchResult.appNotFound;
      }
    }

    // ── Native path: try direct send via platform channel ──
    try {
      final sentCount = await _smsChannel.invokeMethod<int>('sendDirectSms', {
        'phones': numbers,
        'message': message,
      });
      if (sentCount != null && sentCount > 0) {
        return SosLaunchResult.success;
      }
      return SosLaunchResult.appNotFound;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        return SosLaunchResult.permissionDenied;
      }
      // Fallback: open SMS app
      return _fallbackOpenSmsApp(numbers.join(','), message);
    } catch (_) {
      return _fallbackOpenSmsApp(numbers.join(','), message);
    }
  }

  /// Fallback: open SMS app with pre-filled recipients (old behavior).
  static Future<SosLaunchResult> _fallbackOpenSmsApp(String numbers, String message) async {
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
  permissionDenied,
  notSupported,
}

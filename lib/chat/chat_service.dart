import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'chat_models.dart';

class ChatApiException implements Exception {
  final String message;

  ChatApiException(this.message);

  @override
  String toString() => message;
}

class ChatService {
  ChatService({http.Client? client}) : _client = client ?? http.Client();

  static const String _endpointPath = '/api/chat';
  static const String _apiBaseUrl = String.fromEnvironment('CHAT_API_BASE_URL');

  final http.Client _client;

  static String createSessionId() {
    final random = Random();
    return 'session_${DateTime.now().millisecondsSinceEpoch}_${random.nextInt(999999)}';
  }

  Future<ChatResponse> sendMessage({
    required String sessionId,
    required String message,
    required List<ChatMessage> history,
    required String locale,
    required String screenContext,
    required String providerPreference,
  }) async {
    final payload = {
      'contractVersion': '1.0',
      'sessionId': sessionId,
      'message': message,
      'history': history
          .take(16)
          .map((entry) => entry.toRequestJson())
          .toList(growable: false),
      'locale': locale,
      'context': {
        'screen': screenContext,
        'platform': kIsWeb ? 'web' : defaultTargetPlatform.name,
      },
      'providerPreference': providerPreference,
    };

    final response = await _client
        .post(
          _resolveEndpointUri(),
          headers: const {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(payload),
        )
        .timeout(const Duration(seconds: 35));

    Map<String, dynamic> jsonBody;
    try {
      jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw ChatApiException('Unable to parse server response.');
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final error = jsonBody['error'] as Map<String, dynamic>?;
      final message = (error?['message'] ?? 'Chat service failed.') as String;
      throw ChatApiException(message);
    }

    return ChatResponse.fromJson(jsonBody);
  }

  Uri _resolveEndpointUri() {
    if (kIsWeb) {
      return Uri.parse(_endpointPath);
    }

    if (_apiBaseUrl.isEmpty) {
      throw ChatApiException(
        'CHAT_API_BASE_URL is required for non-web targets. Example: --dart-define=CHAT_API_BASE_URL=https://your-site.netlify.app',
      );
    }

    return Uri.parse('${_apiBaseUrl.replaceFirst(RegExp(r'/$'), '')}$_endpointPath');
  }
}

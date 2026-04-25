import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/constants.dart';

class NvidiaService {
  final String apiKey;

  NvidiaService({required this.apiKey});

  Future<String> generateResponse(String userMessage,
      {String? systemPrompt}) async {
    final url = Uri.parse(
      '${AppConstants.nvidiaBaseUrl}/chat/completions',
    );

    final messages = <Map<String, String>>[
      {
        'role': 'system',
        'content': systemPrompt ?? AppConstants.legalSystemPrompt,
      },
      {
        'role': 'user',
        'content': userMessage,
      },
    ];

    final body = jsonEncode({
      'model': AppConstants.nvidiaModel,
      'messages': messages,
      'temperature': 0.7,
      'top_p': 0.95,
      'max_tokens': 2048,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: body,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final choices = data['choices'] as List?;
        if (choices != null && choices.isNotEmpty) {
          return choices[0]['message']?['content'] ?? 'No response generated.';
        }
        return 'No response generated. Please try again.';
      } else {
        final error = jsonDecode(response.body);
        final message = error['detail'] ??
            error['error']?['message'] ??
            'Unknown error (${response.statusCode})';
        return 'Error: $message';
      }
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        return 'Request timed out. Please check your internet connection and try again.';
      }
      return 'Connection error: ${e.toString().split('\n').first}';
    }
  }

  Future<String> summarizeLegalText(String text) async {
    final prompt = '''
Summarize the following Indian legal text in 3-4 simple sentences that any citizen can understand. Use plain language, avoid jargon, and include the key takeaway.

Legal Text:
"$text"
''';
    return generateResponse(prompt,
        systemPrompt:
            'You are a legal text summarizer. Provide concise, accurate summaries in simple language.');
  }

  Future<String> compareLaws(String law1, String law2) async {
    final prompt = '''
Compare these two legal provisions and explain the key differences in simple language:

Law 1: $law1

Law 2: $law2

Provide:
1. Key differences
2. Which situations each applies to
3. Which one is more relevant for common citizens
''';
    return generateResponse(prompt);
  }

  Future<String> legalScenarioAnalysis(String scenario) async {
    final prompt = '''
A citizen describes the following situation:
"$scenario"

As a legal education assistant, explain:
1. Which Indian laws and constitutional provisions are relevant
2. What rights the citizen has in this situation
3. What steps they should consider (for educational purposes only)
4. Where they can seek help (legal aid, helplines, etc.)

Remember: Provide legal EDUCATION only, not legal advice.
''';
    return generateResponse(prompt);
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/constants.dart';

class GitHubModelsService {
  final String token;

  GitHubModelsService({required this.token});

  Future<String> generateResponse(String userMessage,
      {String? systemPrompt, List<Map<String, String>>? conversationHistory}) async {
    final url = Uri.parse(
      '${AppConstants.githubModelsBaseUrl}/chat/completions',
    );

    final messages = <Map<String, String>>[
      {
        'role': 'system',
        'content': systemPrompt ?? AppConstants.legalSystemPrompt,
      },
    ];

    if (conversationHistory != null) {
      messages.addAll(conversationHistory);
    }

    messages.add({
      'role': 'user',
      'content': userMessage,
    });

    final body = jsonEncode({
      'model': AppConstants.githubModel,
      'messages': messages,
      'temperature': 0.7,
      'max_tokens': 2048,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      ).timeout(const Duration(seconds: 45));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final choices = data['choices'] as List?;
        if (choices != null && choices.isNotEmpty) {
          return choices[0]['message']?['content'] ?? 'No response generated.';
        }
        return 'No response generated. Please try again.';
      } else {
        final error = jsonDecode(response.body);
        final message = error['error']?['message'] ??
            error['detail'] ??
            'Unknown error (${response.statusCode})';
        return 'Error: $message';
      }
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        return 'Request timed out. Please try again.';
      }
      return 'Connection error: ${e.toString()}';
    }
  }

  Future<String> explainArticle(
      String articleNumber, String title, String text) async {
    return generateResponse(
      'Explain Article $articleNumber "$title" of the Indian Constitution in simple language for a common citizen.\n\nOfficial text: "$text"\n\nProvide:\n1. Simple explanation\n2. Real-world example\n3. Why it matters to citizens\n4. Hindi translation of key terms',
    );
  }

  Future<String> explainLaw(
      String sectionNumber, String actName, String text) async {
    return generateResponse(
      'Explain Section $sectionNumber of $actName in simple language for common citizens.\n\nLegal text: "$text"\n\nProvide:\n1. What this section means in plain language\n2. When does this apply in daily life\n3. Key terms in Hindi\n4. Punishment/penalty if applicable',
    );
  }
}

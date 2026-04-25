import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/constants.dart';

class GeminiService {
  final String apiKey;

  GeminiService({required this.apiKey});

  Future<String> generateResponse(String userMessage,
      {List<Map<String, String>>? conversationHistory}) async {
    final url = Uri.parse(
      '${AppConstants.geminiBaseUrl}/models/${AppConstants.geminiModel}:generateContent?key=$apiKey',
    );

    final contents = <Map<String, dynamic>>[];

    // Add system instruction
    contents.add({
      'role': 'user',
      'parts': [
        {'text': AppConstants.legalSystemPrompt}
      ]
    });
    contents.add({
      'role': 'model',
      'parts': [
        {
          'text':
              'Understood. I am Nagrik AI, your legal education assistant for Indian Constitution and laws. How can I help you today?'
        }
      ]
    });

    // Add conversation history
    if (conversationHistory != null) {
      for (final msg in conversationHistory) {
        contents.add({
          'role': msg['role'] == 'user' ? 'user' : 'model',
          'parts': [
            {'text': msg['content'] ?? ''}
          ]
        });
      }
    }

    // Add current message
    contents.add({
      'role': 'user',
      'parts': [
        {'text': userMessage}
      ]
    });

    final body = jsonEncode({
      'contents': contents,
      'generationConfig': {
        'temperature': 0.7,
        'topP': 0.95,
        'topK': 40,
        'maxOutputTokens': 2048,
      },
      'safetySettings': [
        {
          'category': 'HARM_CATEGORY_HARASSMENT',
          'threshold': 'BLOCK_ONLY_HIGH'
        },
        {
          'category': 'HARM_CATEGORY_HATE_SPEECH',
          'threshold': 'BLOCK_ONLY_HIGH'
        },
        {
          'category': 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
          'threshold': 'BLOCK_ONLY_HIGH'
        },
        {
          'category': 'HARM_CATEGORY_DANGEROUS_CONTENT',
          'threshold': 'BLOCK_ONLY_HIGH'
        },
      ],
    });

    try {
      final response = await http
          .post(url, headers: {'Content-Type': 'application/json'}, body: body)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidates = data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content['parts'] as List?;
          if (parts != null && parts.isNotEmpty) {
            return parts[0]['text'] ?? 'No response generated.';
          }
        }
        return 'No response generated. Please try again.';
      } else {
        final error = jsonDecode(response.body);
        final message =
            error['error']?['message'] ?? 'Unknown error (${response.statusCode})';
        return 'Error: $message';
      }
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        return 'Request timed out. Please check your internet connection and try again.';
      }
      return 'Connection error: ${e.toString().split('\n').first}';
    }
  }

  Future<String> explainArticle(String articleNumber, String articleTitle,
      String articleText) async {
    final prompt = '''
Explain Article $articleNumber ($articleTitle) of the Indian Constitution in simple language that any common citizen can understand.

Official text: "$articleText"

Please provide:
1. **Simple Explanation** - What this article means in everyday language
2. **Real-world Example** - A practical scenario where this article applies
3. **Why It Matters** - Why this is important for citizens
4. **Related Articles** - Other articles connected to this one
5. **Hindi Translation of Key Terms** - Important legal terms in Hindi
''';
    return generateResponse(prompt);
  }

  Future<String> explainLaw(
      String sectionNumber, String actName, String description) async {
    final prompt = '''
Explain Section $sectionNumber of $actName in simple, citizen-friendly language.

Legal text: "$description"

Please provide:
1. **Simple Explanation** - What this law means for a common person
2. **When Does This Apply?** - Practical situations where this law is relevant
3. **What Should You Do?** - Steps a citizen should take if this applies to them
4. **Punishment/Consequence** - What happens if this law is violated
5. **Important Note** - Any common misconceptions about this law
''';
    return generateResponse(prompt);
  }
}

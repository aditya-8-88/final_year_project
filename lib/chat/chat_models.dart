class ChatCitation {
  final String title;
  final String url;

  const ChatCitation({required this.title, required this.url});

  factory ChatCitation.fromJson(Map<String, dynamic> json) {
    return ChatCitation(
      title: (json['title'] ?? '') as String,
      url: (json['url'] ?? '') as String,
    );
  }
}

class ChatMessage {
  final String role;
  final String content;
  final DateTime timestamp;
  final List<ChatCitation> citations;
  final bool emergencyFlag;
  final String? providerUsed;
  final String? modelUsed;
  final String? disclaimer;

  const ChatMessage({
    required this.role,
    required this.content,
    required this.timestamp,
    this.citations = const [],
    this.emergencyFlag = false,
    this.providerUsed,
    this.modelUsed,
    this.disclaimer,
  });

  Map<String, dynamic> toRequestJson() {
    return {
      'role': role,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class ChatResponse {
  final String contractVersion;
  final String traceId;
  final String answer;
  final List<ChatCitation> citations;
  final String providerUsed;
  final String modelUsed;
  final bool emergencyFlag;
  final String disclaimer;

  const ChatResponse({
    required this.contractVersion,
    required this.traceId,
    required this.answer,
    required this.citations,
    required this.providerUsed,
    required this.modelUsed,
    required this.emergencyFlag,
    required this.disclaimer,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    final rawCitations = (json['citations'] as List<dynamic>? ?? const []);

    return ChatResponse(
      contractVersion: (json['contractVersion'] ?? '1.0') as String,
      traceId: (json['traceId'] ?? '') as String,
      answer: (json['answer'] ?? '') as String,
      citations: rawCitations
          .whereType<Map<String, dynamic>>()
          .map(ChatCitation.fromJson)
          .toList(),
      providerUsed: (json['providerUsed'] ?? 'unknown') as String,
      modelUsed: (json['modelUsed'] ?? 'unknown') as String,
      emergencyFlag: (json['emergencyFlag'] ?? false) as bool,
      disclaimer: (json['disclaimer'] ?? '') as String,
    );
  }
}

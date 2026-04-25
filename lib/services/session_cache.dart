/// In-memory session cache for AI responses and chat sessions.
/// Data persists as long as the app is running (single browser session).
class SessionCache {
  // Landmark cases: key = case name, value = AI detail
  static final Map<String, String> landmarkCaseDetails = {};

  // Article explanations: key = "article_<number>"
  static final Map<String, String> articleExplanations = {};

  // Law explanations: key = "law_<act>_<section>"
  static final Map<String, String> lawExplanations = {};

  // --- Multi-session chat ---
  static final List<ChatSession> chatSessions = [];
  static int _nextSessionId = 1;

  /// Create a new chat session, optionally with page context.
  static ChatSession createSession({String? contextTitle, String? contextPrompt}) {
    final session = ChatSession(
      id: _nextSessionId++,
      title: contextTitle ?? 'New Chat',
      contextPrompt: contextPrompt,
      createdAt: DateTime.now(),
    );
    chatSessions.insert(0, session); // newest first
    return session;
  }

  /// Get session by id
  static ChatSession? getSession(int id) {
    try {
      return chatSessions.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Clear all caches
  static void clearAll() {
    landmarkCaseDetails.clear();
    articleExplanations.clear();
    lawExplanations.clear();
    chatSessions.clear();
    _nextSessionId = 1;
  }
}

class ChatSession {
  final int id;
  String title;
  final String? contextPrompt;
  final DateTime createdAt;
  final List<Map<String, dynamic>> messages; // {content, isUser}
  final List<Map<String, String>> conversationHistory; // {role, content}

  ChatSession({
    required this.id,
    required this.title,
    this.contextPrompt,
    required this.createdAt,
  })  : messages = [],
        conversationHistory = [];

  /// Auto-generate title from first user message
  void updateTitleFromFirstMessage() {
    for (final m in messages) {
      if (m['isUser'] == true) {
        final text = m['content'] as String;
        title = text.length > 50 ? '${text.substring(0, 47)}...' : text;
        return;
      }
    }
  }

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

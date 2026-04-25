import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/gemini_service.dart';
import '../services/nvidia_service.dart';
import '../services/github_models_service.dart';
import '../services/storage_service.dart';
import '../services/session_cache.dart';
import '../widgets/chat_bubble.dart';

class ChatbotScreen extends StatefulWidget {
  /// Optional: resume an existing session
  final int? sessionId;

  /// Optional: page context for a new contextual session
  final String? contextTitle;
  final String? contextPrompt;

  const ChatbotScreen({
    super.key,
    this.sessionId,
    this.contextTitle,
    this.contextPrompt,
  });

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  late ChatSession _session;

  @override
  void initState() {
    super.initState();
    // Resume existing session or create new one
    if (widget.sessionId != null) {
      _session = SessionCache.getSession(widget.sessionId!)!;
      _restoreMessages();
    } else {
      _session = SessionCache.createSession(
        contextTitle: widget.contextTitle,
        contextPrompt: widget.contextPrompt,
      );
      // If there's context, auto-send the context prompt
      if (widget.contextPrompt != null) {
        _session.title = widget.contextTitle ?? 'AI Explanation';
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _sendContextMessage();
        });
      }
    }
  }

  void _restoreMessages() {
    for (final m in _session.messages) {
      _messages.add(ChatMessage(
        content: m['content'] as String,
        isUser: m['isUser'] as bool,
      ));
    }
    _scrollToBottom();
  }

  Future<void> _sendContextMessage() async {
    // Show a user-visible message about the context
    final displayMsg = widget.contextTitle ?? 'Explain this in detail';
    final userMessage = ChatMessage(content: displayMsg, isUser: true);
    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });
    _session.messages.add({'content': displayMsg, 'isUser': true});
    _session.conversationHistory.add({'role': 'user', 'content': widget.contextPrompt!});
    _session.updateTitleFromFirstMessage();

    final response = await _callAI(widget.contextPrompt!);

    _session.conversationHistory.add({'role': 'assistant', 'content': response});
    _session.messages.add({'content': response, 'isUser': false});

    if (mounted) {
      setState(() {
        _messages.add(ChatMessage(content: response, isUser: false));
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  static const List<String> _suggestedQuestions = [
    'What are my Fundamental Rights?',
    'Explain Article 21 in simple words',
    'What is the RTI Act and how to file it?',
    'What are the new criminal laws (BNS, BNSS)?',
    'What happens during a National Emergency?',
    'Explain the Preamble of the Constitution',
    'What is the difference between Lok Sabha and Rajya Sabha?',
    'How can I file a consumer complaint?',
    'What are Fundamental Duties?',
    'What is the DPDP Act 2023?',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _curatePrompt(String rawQuery) {
    return '''
The user (an Indian citizen) is asking the following question. Understand their real intent even if phrased casually, and provide a helpful, accurate, and simple answer.

User's question: "$rawQuery"

Instructions for your response:
- First identify what legal topic they are asking about.
- If the question is vague, interpret it in the most helpful way for a common citizen.
- Explain using simple everyday language with real-life examples.
- Always cite the specific Article, Section, or Act.
- Include the Hindi term for key legal concepts if relevant.
- If this involves a practical situation, provide actionable steps they can take.
- Keep the response focused and concise (150-250 words).
''';
  }

  Future<String> _callAI(String prompt) async {
    final githubToken = await StorageService.getGithubToken();
    final geminiKey = await StorageService.getGeminiApiKey();
    final nvidiaKey = await StorageService.getNvidiaApiKey();
    final history = _session.conversationHistory.length > 2
        ? _session.conversationHistory.sublist(0, _session.conversationHistory.length - 1)
        : null;

    if (githubToken.isNotEmpty) {
      final service = GitHubModelsService(token: githubToken);
      return service.generateResponse(prompt, conversationHistory: history);
    } else if (geminiKey.isNotEmpty) {
      final service = GeminiService(apiKey: geminiKey);
      return service.generateResponse(prompt, conversationHistory: history);
    } else if (nvidiaKey.isNotEmpty) {
      final service = NvidiaService(apiKey: nvidiaKey);
      return service.generateResponse(prompt);
    } else {
      return '⚠️ **No AI provider configured.**\n\nPlease go to **⋮ menu → About → Settings** to enter an API key.';
    }
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(content: text.trim(), isUser: true);
    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    _session.messages.add({'content': text.trim(), 'isUser': true});
    _session.conversationHistory.add({'role': 'user', 'content': text.trim()});
    _session.updateTitleFromFirstMessage();

    final curatedPrompt = _curatePrompt(text.trim());
    final response = await _callAI(curatedPrompt);

    _session.conversationHistory.add({'role': 'assistant', 'content': response});
    _session.messages.add({'content': response, 'isUser': false});

    if (mounted) {
      setState(() {
        _messages.add(ChatMessage(content: response, isUser: false));
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _clearChat() {
    _session.messages.clear();
    _session.conversationHistory.clear();
    setState(() {
      _messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nagrik AI Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear chat',
            onPressed: _messages.isEmpty ? null : _clearChat,
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: _messages.isEmpty
                ? _buildWelcomeView(theme)
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _messages.length && _isLoading) {
                        return const TypingIndicator();
                      }
                      final msg = _messages[index];
                      return ChatBubble(
                        message: msg.content,
                        isUser: msg.isUser,
                        source: msg.source,
                        timestamp: msg.timestamp,
                      );
                    },
                  ),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: _isLoading ? null : _sendMessage,
                      decoration: InputDecoration(
                        hintText: 'Ask about Constitution, laws, rights...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    mini: true,
                    onPressed: _isLoading
                        ? null
                        : () => _sendMessage(_controller.text),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeView(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Icon(
                Icons.smart_toy,
                size: 64,
                color: theme.colorScheme.primary.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              Text(
                'Nagrik AI',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your AI-powered legal education assistant.\n'
                'Ask anything about the Indian Constitution, laws, and your rights.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '⚠️ This provides legal EDUCATION, not legal advice',
                  style: TextStyle(fontSize: 12, color: Colors.amber),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Try asking:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 12),
              ..._suggestedQuestions.map((q) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _sendMessage(q),
                        style: OutlinedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        child: Text(q, style: const TextStyle(fontSize: 13)),
                      ),
                    ),
                  )),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

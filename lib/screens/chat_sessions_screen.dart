import 'package:flutter/material.dart';
import '../services/session_cache.dart';
import 'chatbot_screen.dart';

class ChatSessionsScreen extends StatefulWidget {
  final bool showAppBar;

  const ChatSessionsScreen({super.key, this.showAppBar = true});

  @override
  State<ChatSessionsScreen> createState() => _ChatSessionsScreenState();
}

class _ChatSessionsScreenState extends State<ChatSessionsScreen> {
  void _startNewChat() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ChatbotScreen()),
    );
    setState(() {}); // refresh list after returning
  }

  void _openSession(ChatSession session) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatbotScreen(sessionId: session.id),
      ),
    );
    setState(() {});
  }

  void _deleteSession(ChatSession session) {
    setState(() {
      SessionCache.chatSessions.removeWhere((s) => s.id == session.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sessions = SessionCache.chatSessions;

    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: const Text('AI Assistant'),
            )
          : null,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startNewChat,
        icon: const Icon(Icons.add),
        label: const Text('New Chat'),
      ),
      body: sessions.isEmpty
          ? _buildEmptyState(theme)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                final msgCount = session.messages.length;
                final lastMsg = msgCount > 0
                    ? session.messages.last['content'] as String
                    : 'No messages yet';
                final isContextual = session.contextPrompt != null;

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: isContextual
                          ? Colors.amber.withOpacity(0.15)
                          : theme.colorScheme.primary.withOpacity(0.1),
                      child: Icon(
                        isContextual ? Icons.auto_awesome : Icons.chat_bubble_outline,
                        color: isContextual
                            ? Colors.amber.shade700
                            : theme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      session.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          lastMsg,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              session.timeAgo,
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.textTheme.bodySmall?.color
                                    ?.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '$msgCount messages',
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.textTheme.bodySmall?.color
                                    ?.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline,
                          size: 20, color: Colors.red.shade300),
                      onPressed: () => _deleteSession(session),
                    ),
                    onTap: () => _openSession(session),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.smart_toy,
              size: 64,
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No conversations yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start a new chat or use the AI button on any page\nto get contextual explanations.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: theme.textTheme.bodySmall?.color,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _startNewChat,
              icon: const Icon(Icons.add),
              label: const Text('Start New Chat'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

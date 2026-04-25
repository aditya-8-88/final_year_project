import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat_models.dart';
import 'chat_service.dart';

class GlobalChatShell extends StatefulWidget {
  const GlobalChatShell({super.key, required this.child});

  final Widget child;

  @override
  State<GlobalChatShell> createState() => _GlobalChatShellState();
}

class _GlobalChatShellState extends State<GlobalChatShell> {
  final ChatService _chatService = ChatService();
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _messagesController = ScrollController();

  late final String _sessionId;
  final List<ChatMessage> _messages = [];

  bool _isOpen = false;
  bool _isSending = false;
  String _providerPreference = 'auto';

  @override
  void initState() {
    super.initState();
    _sessionId = ChatService.createSessionId();
    _messages.add(
      ChatMessage(
        role: 'assistant',
        content:
            'Hi, I am your safety and legal awareness assistant. I can help with legal rights, reporting steps, and emergency guidance.',
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _messagesController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _isSending) {
      return;
    }

    final now = DateTime.now();
    final userMessage = ChatMessage(
      role: 'user',
      content: text,
      timestamp: now,
    );

    setState(() {
      _messages.add(userMessage);
      _isSending = true;
      _inputController.clear();
    });

    _scrollToBottom();

    try {
      final locale = Localizations.maybeLocaleOf(context)?.toLanguageTag() ?? 'en-IN';
      final response = await _chatService.sendMessage(
        sessionId: _sessionId,
        message: text,
        history: _messages,
        locale: locale,
        screenContext: _currentScreenContext(),
        providerPreference: _providerPreference,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _messages.add(
          ChatMessage(
            role: 'assistant',
            content: response.answer,
            timestamp: DateTime.now(),
            citations: response.citations,
            emergencyFlag: response.emergencyFlag,
            providerUsed: response.providerUsed,
            modelUsed: response.modelUsed,
            disclaimer: response.disclaimer,
          ),
        );
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _messages.add(
          ChatMessage(
            role: 'assistant',
            content:
                'I could not reach the chat service right now. Please try again in a moment. If this is urgent, call 112 or 181 immediately.',
            timestamp: DateTime.now(),
          ),
        );
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_messagesController.hasClients) {
        return;
      }

      _messagesController.animateTo(
        _messagesController.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
    });
  }

  String _currentScreenContext() {
    final routeName = ModalRoute.of(context)?.settings.name;
    if (routeName != null && routeName.isNotEmpty) {
      return routeName;
    }

    return 'global_overlay';
  }

  Future<void> _openCitation(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final keyboardInset = media.viewInsets.bottom;
    final safeBottom = media.viewPadding.bottom;

    final double baseBottom = keyboardInset > 0 ? keyboardInset + 12.0 : safeBottom + 92.0;
    final double bubbleBottom = math.max(baseBottom, 24.0).toDouble();

    final double panelWidth = math.min(420.0, media.size.width - 20).toDouble();
    final double panelHeight = math.min(560.0, media.size.height * 0.72).toDouble();

    return Stack(
      children: [
        widget.child,
        Positioned(
          right: 10,
          bottom: bubbleBottom,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _isOpen
                ? _ChatPanel(
                    key: const ValueKey('chat-panel'),
                    width: panelWidth,
                    height: panelHeight,
                    messages: _messages,
                    isSending: _isSending,
                    providerPreference: _providerPreference,
                    inputController: _inputController,
                    messagesController: _messagesController,
                    onClose: () => setState(() => _isOpen = false),
                    onProviderChanged: (value) {
                      setState(() {
                        _providerPreference = value;
                      });
                    },
                    onSend: _sendMessage,
                    onCitationTap: _openCitation,
                  )
                : FloatingActionButton.extended(
                    key: const ValueKey('chat-fab'),
                    heroTag: 'global_chat_fab',
                    backgroundColor: const Color(0xFF1A237E),
                    foregroundColor: Colors.white,
                    icon: const Icon(Icons.support_agent),
                    label: const Text('Chat'),
                    onPressed: () {
                      setState(() {
                        _isOpen = true;
                      });
                      _scrollToBottom();
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class _ChatPanel extends StatelessWidget {
  const _ChatPanel({
    super.key,
    required this.width,
    required this.height,
    required this.messages,
    required this.isSending,
    required this.providerPreference,
    required this.inputController,
    required this.messagesController,
    required this.onClose,
    required this.onProviderChanged,
    required this.onSend,
    required this.onCitationTap,
  });

  final double width;
  final double height;
  final List<ChatMessage> messages;
  final bool isSending;
  final String providerPreference;
  final TextEditingController inputController;
  final ScrollController messagesController;
  final VoidCallback onClose;
  final ValueChanged<String> onProviderChanged;
  final VoidCallback onSend;
  final Future<void> Function(String url) onCitationTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 14,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1A237E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.support_agent, color: Colors.white),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Safety Chat Assistant',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: const Color(0xFF1A237E),
                      value: providerPreference,
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      onChanged: isSending
                          ? null
                          : (value) {
                              if (value != null) {
                                onProviderChanged(value);
                              }
                            },
                      items: const [
                        DropdownMenuItem(value: 'auto', child: Text('Auto')),
                        DropdownMenuItem(value: 'gemini', child: Text('Gemini')),
                        DropdownMenuItem(value: 'nvidia', child: Text('NVIDIA')),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close chat',
                    onPressed: onClose,
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: messagesController,
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUser = message.role == 'user';

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      constraints: BoxConstraints(maxWidth: width * 0.84),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUser ? const Color(0xFFE8EAF6) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isUser ? const Color(0xFFC5CAE9) : Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.content,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade900,
                              height: 1.4,
                            ),
                          ),
                          if (!isUser && message.emergencyFlag) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: Text(
                                'Emergency context detected',
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                          if (!isUser && message.citations.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: message.citations
                                  .map(
                                    (citation) => ActionChip(
                                      label: Text(
                                        citation.title,
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                      onPressed: () => onCitationTap(citation.url),
                                    ),
                                  )
                                  .toList(growable: false),
                            ),
                          ],
                          if (!isUser && message.providerUsed != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Provider: ${message.providerUsed} | Model: ${message.modelUsed ?? 'unknown'}',
                              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                            ),
                          ],
                          if (!isUser && message.disclaimer != null && message.disclaimer!.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              message.disclaimer!,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (isSending)
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Assistant is thinking...', style: TextStyle(fontSize: 12)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      textInputAction: TextInputAction.send,
                      maxLines: 3,
                      minLines: 1,
                      onSubmitted: (_) => onSend(),
                      decoration: const InputDecoration(
                        hintText: 'Ask about rights, FIR, helplines, or legal steps...',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: isSending ? null : onSend,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1A237E),
                      foregroundColor: Colors.white,
                    ),
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

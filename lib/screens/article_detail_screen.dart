import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/storage_service.dart';
import 'chatbot_screen.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ConstitutionArticle article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmark();
  }

  Future<void> _checkBookmark() async {
    final canonicalId = 'article_${widget.article.articleNumber}';
    final legacyId = 'art_${widget.article.articleNumber}';
    final bookmarked = await StorageService.isBookmarked(canonicalId) ||
        await StorageService.isBookmarked(legacyId);
    if (mounted) setState(() => _isBookmarked = bookmarked);
  }

  Future<void> _toggleBookmark() async {
    final canonicalId = 'article_${widget.article.articleNumber}';
    final legacyId = 'art_${widget.article.articleNumber}';

    if (_isBookmarked) {
      await StorageService.removeBookmark(canonicalId);
      await StorageService.removeBookmark(legacyId);
    } else {
      // Clean any legacy entry so users don't get duplicate article bookmarks.
      await StorageService.removeBookmark(legacyId);
      await StorageService.addBookmark(Bookmark(
        id: canonicalId,
        title: 'Article ${widget.article.articleNumber}',
        type: 'article',
        subtitle: widget.article.title,
      ));
    }
    setState(() => _isBookmarked = !_isBookmarked);
  }

  void _openAIChat() {
    final article = widget.article;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatbotScreen(
          contextTitle: 'Article ${article.articleNumber}: ${article.title}',
          contextPrompt:
              'Explain Article ${article.articleNumber} (${article.title}) of the Indian Constitution in detail.\n\n'
              'Official text: "${article.description}"\n\n'
              'Provide: 1) Simple explanation in everyday language, 2) Real-world example, '
              '3) Why it matters for citizens, 4) Related articles or laws. '
              'Use Hindi terms for key legal concepts where helpful.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final article = widget.article;

    return Scaffold(
      appBar: AppBar(
        title: Text('Article ${article.articleNumber}'),
        actions: [
          IconButton(
            icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: _toggleBookmark,
            tooltip: _isBookmarked ? 'Remove bookmark' : 'Bookmark',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Article ${article.articleNumber}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Chip(
                            label: Text(article.category,
                                style: const TextStyle(fontSize: 12)),
                            backgroundColor:
                                theme.colorScheme.secondary.withOpacity(0.1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${article.part} - ${article.partTitle}',
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Official Text
                _SectionCard(
                  icon: Icons.description,
                  title: 'Official Text',
                  color: Colors.blue,
                  child: SelectableText(
                    article.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.7,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Simple Explanation
                _SectionCard(
                  icon: Icons.lightbulb,
                  title: 'Simple Explanation',
                  color: Colors.amber,
                  child: SelectableText(
                    article.simpleExplanation,
                    style: const TextStyle(fontSize: 14, height: 1.7),
                  ),
                ),

                const SizedBox(height: 16),

                // Keywords
                if (article.keywords.isNotEmpty) ...[
                  _SectionCard(
                    icon: Icons.tag,
                    title: 'Keywords',
                    color: Colors.teal,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: article.keywords
                          .map((k) => Chip(
                                label: Text(k, style: const TextStyle(fontSize: 12)),
                                visualDensity: VisualDensity.compact,
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAIChat,
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Ask AI'),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

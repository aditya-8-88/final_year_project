import 'package:flutter/material.dart';
import '../data/laws_data.dart';
import '../models/models.dart';
import '../services/storage_service.dart';
import '../widgets/article_card.dart';
import 'chatbot_screen.dart';

class LawsScreen extends StatefulWidget {
  final bool showAppBar;

  const LawsScreen({super.key, this.showAppBar = true});

  @override
  State<LawsScreen> createState() => _LawsScreenState();
}

class _LawsScreenState extends State<LawsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: widget.showAppBar ? AppBar(title: const Text('Laws & Acts')) : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search laws, sections, keywords...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: _searchQuery.isNotEmpty
                ? _buildSearchResults(theme)
                : _buildCategories(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: indianLaws.length,
      itemBuilder: (context, index) {
        final category = indianLaws[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _categoryColor(index).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_categoryIcon(category.icon),
                  color: _categoryColor(index)),
            ),
            title: Text(
              category.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            subtitle: Text(
              '${category.sections.length} sections • ${category.description}',
              style: const TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            children: category.sections
                .map((section) => ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      leading: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'S.${section.sectionNumber}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      title: Text(section.title,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      subtitle: Text(
                        section.simpleExplanation,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing:
                          const Icon(Icons.chevron_right, size: 18),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              LawDetailScreen(section: section),
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(ThemeData theme) {
    final q = _searchQuery.toLowerCase();
    final results = <LawSection>[];
    for (final cat in indianLaws) {
      for (final section in cat.sections) {
        if (section.title.toLowerCase().contains(q) ||
            section.description.toLowerCase().contains(q) ||
            section.simpleExplanation.toLowerCase().contains(q) ||
            section.actName.toLowerCase().contains(q) ||
            section.sectionNumber.toLowerCase().contains(q) ||
            section.keywords.any((k) => k.toLowerCase().contains(q))) {
          results.add(section);
        }
      }
    }

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: theme.textTheme.bodySmall?.color),
            const SizedBox(height: 12),
            Text('No laws found for "$_searchQuery"'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return LawSectionCard(
          section: results[index],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LawDetailScreen(section: results[index]),
            ),
          ),
        );
      },
    );
  }

  IconData _categoryIcon(String icon) {
    switch (icon) {
      case 'gavel': return Icons.gavel;
      case 'shield': return Icons.shield;
      case 'visibility': return Icons.visibility;
      case 'computer': return Icons.computer;
      case 'shopping_cart': return Icons.shopping_cart;
      case 'directions_car': return Icons.directions_car;
      case 'eco': return Icons.eco;
      case 'engineering': return Icons.engineering;
      case 'lock': return Icons.lock;
      default: return Icons.article;
    }
  }

  Color _categoryColor(int index) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.indigo,
      Colors.orange,
      Colors.teal,
      Colors.brown,
      Colors.purple,
      Colors.cyan,
    ];
    return colors[index % colors.length];
  }
}

class LawDetailScreen extends StatefulWidget {
  final LawSection section;

  const LawDetailScreen({super.key, required this.section});

  @override
  State<LawDetailScreen> createState() => _LawDetailScreenState();
}

class _LawDetailScreenState extends State<LawDetailScreen> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmark();
  }

  Future<void> _checkBookmark() async {
    final id = 'law_${widget.section.actName}_${widget.section.sectionNumber}';
    final bookmarked = await StorageService.isBookmarked(id);
    if (mounted) setState(() => _isBookmarked = bookmarked);
  }

  Future<void> _toggleBookmark() async {
    final id = 'law_${widget.section.actName}_${widget.section.sectionNumber}';
    if (_isBookmarked) {
      await StorageService.removeBookmark(id);
    } else {
      await StorageService.addBookmark(Bookmark(
        id: id,
        title: 'S.${widget.section.sectionNumber} ${widget.section.actName}',
        type: 'law',
        subtitle: widget.section.title,
      ));
    }
    setState(() => _isBookmarked = !_isBookmarked);
  }

  void _openAIChat() {
    final section = widget.section;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatbotScreen(
          contextTitle: 'S.${section.sectionNumber} ${section.actName}',
          contextPrompt:
              'Explain Section ${section.sectionNumber} of ${section.actName} in detail for a common citizen.\n\n'
              'Section title: "${section.title}"\n'
              'Text: "${section.description}"\n\n'
              'Provide: 1) Simple explanation, 2) Real-world example, 3) Penalties if applicable, '
              '4) How to use this provision, 5) Related sections. Use Hindi terms where helpful.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final section = widget.section;

    return Scaffold(
      appBar: AppBar(
        title: Text('Section ${section.sectionNumber}'),
        actions: [
          IconButton(
            icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: _toggleBookmark,
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
                    color: Colors.orange.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange.withOpacity(0.2)),
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
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Section ${section.sectionNumber}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        section.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        section.actName,
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Legal Text
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.description, color: Colors.blue, size: 22),
                            SizedBox(width: 8),
                            Text('Legal Text',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 14),
                        SelectableText(
                          section.description,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.7,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Simple Explanation
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.lightbulb, color: Colors.amber, size: 22),
                            SizedBox(width: 8),
                            Text('Simple Explanation',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 14),
                        SelectableText(
                          section.simpleExplanation,
                          style: const TextStyle(fontSize: 14, height: 1.7),
                        ),
                      ],
                    ),
                  ),
                ),

                // Punishment
                if (section.punishment.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Card(
                    color: Colors.red.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.warning_amber, color: Colors.red,
                                  size: 22),
                              SizedBox(width: 8),
                              Text('Punishment / Penalty',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            section.punishment,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

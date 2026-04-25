import 'package:flutter/material.dart';
import '../data/constitution_data.dart';
import '../models/models.dart';
import '../widgets/article_card.dart';
import 'article_detail_screen.dart';

class ConstitutionExplorerScreen extends StatefulWidget {
  const ConstitutionExplorerScreen({super.key});

  @override
  State<ConstitutionExplorerScreen> createState() =>
      _ConstitutionExplorerScreenState();
}

class _ConstitutionExplorerScreenState
    extends State<ConstitutionExplorerScreen> {
  String _searchQuery = '';
  String? _selectedPart;

  List<ConstitutionArticle> get _filteredArticles {
    List<ConstitutionArticle> articles = [];
    for (final part in constitutionParts) {
      if (_selectedPart == null || part.partNumber == _selectedPart) {
        articles.addAll(part.articles);
      }
    }
    if (_searchQuery.isEmpty) return articles;
    final q = _searchQuery.toLowerCase();
    return articles.where((a) {
      return a.title.toLowerCase().contains(q) ||
          a.simpleExplanation.toLowerCase().contains(q) ||
          a.articleNumber.toLowerCase().contains(q) ||
          a.category.toLowerCase().contains(q) ||
          a.keywords.any((k) => k.toLowerCase().contains(q));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final articles = _filteredArticles;

    return Scaffold(
      appBar: AppBar(title: const Text('Constitution Explorer')),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Search articles, rights, keywords...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () =>
                                setState(() => _searchQuery = ''),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 38,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _FilterChip(
                        label: 'All Parts',
                        selected: _selectedPart == null,
                        onTap: () =>
                            setState(() => _selectedPart = null),
                      ),
                      ...constitutionParts.map((part) => _FilterChip(
                            label: part.partNumber,
                            selected: _selectedPart == part.partNumber,
                            onTap: () => setState(
                                () => _selectedPart = part.partNumber),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${articles.length} articles found',
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                const Spacer(),
                if (_selectedPart != null)
                  TextButton(
                    onPressed: () => setState(() => _selectedPart = null),
                    child: const Text('Clear filter'),
                  ),
              ],
            ),
          ),

          // Preamble card if no filter
          if (_selectedPart == null && _searchQuery.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: theme.colorScheme.primary.withOpacity(0.05),
                child: ListTile(
                  leading: Icon(Icons.auto_stories,
                      color: theme.colorScheme.primary),
                  title: const Text('The Preamble',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text(
                      'The soul of the Constitution - read the full text and meaning'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showPreamble(context),
                ),
              ),
            ),

          // Articles list
          Expanded(
            child: articles.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 48,
                            color: theme.textTheme.bodySmall?.color),
                        const SizedBox(height: 12),
                        Text('No articles found for "$_searchQuery"',
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return ArticleCard(
                        article: article,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ArticleDetailScreen(article: article),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showPreamble(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.auto_stories, color: Colors.amber),
            SizedBox(width: 8),
            Text('The Preamble'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(
                preambleText.trim(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              const Text(
                'What it means:',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SelectableText(
                preambleExplanation.trim(),
                style: const TextStyle(fontSize: 13, height: 1.6),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: theme.colorScheme.primary.withOpacity(0.15),
        checkmarkColor: theme.colorScheme.primary,
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          color: selected ? theme.colorScheme.primary : null,
        ),
      ),
    );
  }
}

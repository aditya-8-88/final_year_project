import 'package:flutter/material.dart';
import '../data/constitution_data.dart';
import '../data/laws_data.dart';
import '../data/glossary_data.dart';
import '../models/models.dart';
import 'article_detail_screen.dart';
import 'laws_screen.dart';
import 'landmark_cases_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  // Quick suggestion chips for common topics
  static const List<String> _suggestions = [
    'property',
    'land',
    'women',
    'marriage',
    'divorce',
    'fundamental rights',
    'freedom of speech',
    'arrest',
    'bail',
    'privacy',
    'reservation',
    'environment',
    'labour',
    'consumer',
    'cyber crime',
    'dowry',
    'education',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              autofocus: true,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search anything — laws, articles, cases, terms...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: _query.length < 2
                ? _buildEmptyState(theme)
                : _buildResults(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Try searching for',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _suggestions.map((s) => ActionChip(
              label: Text(s, style: const TextStyle(fontSize: 13)),
              onPressed: () {
                _controller.text = s;
                setState(() => _query = s);
              },
            )).toList(),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Searches across articles, laws, landmark cases,\namendments & glossary',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Split query into individual words for smarter matching
  bool _matchesQuery(String text, String q, List<String> words) {
    final lower = text.toLowerCase();
    // Exact phrase match
    if (lower.contains(q)) return true;
    // All individual words present (for multi-word queries like "land property")
    if (words.length > 1 && words.every((w) => lower.contains(w))) return true;
    return false;
  }

  bool _fieldMatches(List<String> fields, String q, List<String> words) {
    return fields.any((f) => _matchesQuery(f, q, words));
  }

  Widget _buildResults(ThemeData theme) {
    final q = _query.toLowerCase().trim();
    final words = q.split(RegExp(r'\s+')).where((w) => w.length >= 2).toList();

    // Search articles
    final articles = <ConstitutionArticle>[];
    for (final part in constitutionParts) {
      for (final article in part.articles) {
        if (_fieldMatches([
          article.articleNumber,
          article.title,
          article.description,
          article.simpleExplanation,
          article.category,
          ...article.keywords,
        ], q, words)) {
          articles.add(article);
        }
      }
    }

    // Search laws
    final laws = <LawSection>[];
    for (final cat in indianLaws) {
      for (final section in cat.sections) {
        if (_fieldMatches([
          section.title,
          section.description,
          section.simpleExplanation,
          section.actName,
          section.punishment,
          ...section.keywords,
        ], q, words)) {
          laws.add(section);
        }
      }
    }

    // Search landmark cases
    final cases = <Map<String, String>>[];
    for (final c in LandmarkCasesScreen.cases) {
      if (_fieldMatches([
        c['case'] ?? '',
        c['category'] ?? '',
        c['significance'] ?? '',
        c['year'] ?? '',
      ], q, words)) {
        cases.add(c);
      }
    }

    // Search amendments
    final amendments = <Amendment>[];
    for (final a in keyAmendments) {
      if (_fieldMatches([
        '${a.number}',
        a.year,
        a.description,
        a.impact,
        ...a.articlesAffected,
      ], q, words)) {
        amendments.add(a);
      }
    }

    // Search glossary
    final glossary = legalGlossary.where((g) {
      return _fieldMatches([
        g.term,
        g.definition,
        g.hindiTerm,
        g.example,
      ], q, words);
    }).toList();

    final totalResults = articles.length + laws.length + cases.length +
        amendments.length + glossary.length;

    if (totalResults == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off,
                size: 48, color: theme.textTheme.bodySmall?.color),
            const SizedBox(height: 12),
            Text('No results for "$_query"'),
            const SizedBox(height: 8),
            Text(
              'Try different keywords or check spelling',
              style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Text(
          '$totalResults results found',
          style: TextStyle(
            fontSize: 12,
            color: theme.textTheme.bodySmall?.color,
          ),
        ),
        const SizedBox(height: 12),

        // Articles section
        if (articles.isNotEmpty) ...[
          _sectionHeader('Constitution Articles', articles.length, Icons.article),
          ...articles.take(10).map((article) => ListTile(
                leading: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Art.${article.articleNumber}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  ),
                ),
                title: Text(article.title,
                    style: const TextStyle(fontSize: 14)),
                subtitle: Text(article.simpleExplanation,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleDetailScreen(article: article),
                  ),
                ),
              )),
          if (articles.length > 10)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                '...and ${articles.length - 10} more articles',
                style: TextStyle(
                    fontSize: 12, color: theme.textTheme.bodySmall?.color),
              ),
            ),
          const SizedBox(height: 16),
        ],

        // Laws section
        if (laws.isNotEmpty) ...[
          _sectionHeader('Laws & Sections', laws.length, Icons.gavel),
          ...laws.take(10).map((section) => ListTile(
                leading: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'S.${section.sectionNumber}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.orange,
                    ),
                  ),
                ),
                title: Text(section.title,
                    style: const TextStyle(fontSize: 14)),
                subtitle: Text(section.actName,
                    style: const TextStyle(fontSize: 12)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LawDetailScreen(section: section),
                  ),
                ),
              )),
          if (laws.length > 10)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                '...and ${laws.length - 10} more laws',
                style: TextStyle(
                    fontSize: 12, color: theme.textTheme.bodySmall?.color),
              ),
            ),
          const SizedBox(height: 16),
        ],

        // Landmark Cases section
        if (cases.isNotEmpty) ...[
          _sectionHeader('Landmark Cases', cases.length, Icons.account_balance),
          ...cases.take(10).map((c) => ListTile(
                leading: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    c['year'] ?? '',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.purple,
                    ),
                  ),
                ),
                title: Text(c['case'] ?? '',
                    style: const TextStyle(fontSize: 14)),
                subtitle: Text(c['significance'] ?? '',
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                isThreeLine: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LandmarkCasesScreen(),
                  ),
                ),
              )),
          if (cases.length > 10)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                '...and ${cases.length - 10} more cases',
                style: TextStyle(
                    fontSize: 12, color: theme.textTheme.bodySmall?.color),
              ),
            ),
          const SizedBox(height: 16),
        ],

        // Amendments section
        if (amendments.isNotEmpty) ...[
          _sectionHeader('Amendments', amendments.length, Icons.history_edu),
          ...amendments.take(10).map((a) => ListTile(
                leading: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${a.number}th',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal,
                    ),
                  ),
                ),
                title: Text('Amendment ${a.number} (${a.year})',
                    style: const TextStyle(fontSize: 14)),
                subtitle: Text(a.description,
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                isThreeLine: true,
              )),
          if (amendments.length > 10)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                '...and ${amendments.length - 10} more amendments',
                style: TextStyle(
                    fontSize: 12, color: theme.textTheme.bodySmall?.color),
              ),
            ),
          const SizedBox(height: 16),
        ],

        // Glossary section
        if (glossary.isNotEmpty) ...[
          _sectionHeader('Glossary Terms', glossary.length, Icons.menu_book),
          ...glossary.take(10).map((term) => ListTile(
                leading: const Icon(Icons.translate, size: 20),
                title: Text(term.term,
                    style: const TextStyle(fontSize: 14)),
                subtitle: Text(term.definition,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: term.hindiTerm.isNotEmpty
                    ? Text(term.hindiTerm,
                        style: const TextStyle(fontSize: 12))
                    : null,
              )),
          if (glossary.length > 10)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                '...and ${glossary.length - 10} more terms',
                style: TextStyle(
                    fontSize: 12, color: theme.textTheme.bodySmall?.color),
              ),
            ),
        ],

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _sectionHeader(String title, int count, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('$count', style: const TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}

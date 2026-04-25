import 'package:flutter/material.dart';
import '../data/glossary_data.dart';

class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({super.key});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final q = _searchQuery.toLowerCase();
    final filtered = q.isEmpty
        ? legalGlossary
        : legalGlossary.where((g) {
            return g.term.toLowerCase().contains(q) ||
                g.definition.toLowerCase().contains(q) ||
                g.hindiTerm.toLowerCase().contains(q);
          }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Legal Glossary')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search legal terms (English or Hindi)...',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${filtered.length} terms',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 48,
                            color: theme.textTheme.bodySmall?.color),
                        const SizedBox(height: 12),
                        Text('No terms found for "$_searchQuery"'),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final term = filtered[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            radius: 18,
                            backgroundColor:
                                theme.colorScheme.primary.withOpacity(0.1),
                            child: Text(
                              term.term[0].toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          title: Text(
                            term.term,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            term.hindiTerm,
                            style: const TextStyle(fontSize: 12),
                          ),
                          childrenPadding:
                              const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Definition:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    term.definition,
                                    style: const TextStyle(
                                        fontSize: 13, height: 1.5),
                                  ),
                                  if (term.example.isNotEmpty) ...[
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.05),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        border: Border.all(
                                          color:
                                              Colors.blue.withOpacity(0.15),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.lightbulb_outline,
                                              size: 16, color: Colors.blue),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              term.example,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                height: 1.5,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

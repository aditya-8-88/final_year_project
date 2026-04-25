import 'package:flutter/material.dart';
import '../data/constitution_data.dart';
import '../models/models.dart';
import '../widgets/article_card.dart';
import 'article_detail_screen.dart';

class FundamentalRightsScreen extends StatelessWidget {
  const FundamentalRightsScreen({super.key});

  List<ConstitutionArticle> get _rightsArticles {
    final part3 =
        constitutionParts.where((p) => p.partNumber == 'Part III').toList();
    if (part3.isEmpty) return [];
    return part3.first.articles;
  }

  Map<String, List<ConstitutionArticle>> get _groupedByCategory {
    final map = <String, List<ConstitutionArticle>>{};
    for (final a in _rightsArticles) {
      map.putIfAbsent(a.category, () => []).add(a);
    }
    return map;
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Right to Equality':
        return Icons.balance;
      case 'Right to Freedom':
        return Icons.flight_takeoff;
      case 'Right against Exploitation':
        return Icons.shield;
      case 'Right to Freedom of Religion':
        return Icons.temple_hindu;
      case 'Cultural and Educational Rights':
        return Icons.school;
      case 'Right to Constitutional Remedies':
        return Icons.gavel;
      default:
        return Icons.article;
    }
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Right to Equality':
        return Colors.blue;
      case 'Right to Freedom':
        return Colors.green;
      case 'Right against Exploitation':
        return Colors.red;
      case 'Right to Freedom of Religion':
        return Colors.orange;
      case 'Cultural and Educational Rights':
        return Colors.purple;
      case 'Right to Constitutional Remedies':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final grouped = _groupedByCategory;

    return Scaffold(
      appBar: AppBar(title: const Text('Fundamental Rights')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: theme.colorScheme.primary.withOpacity(0.05),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.shield, color: theme.colorScheme.primary),
                            const SizedBox(width: 8),
                            const Text(
                              'Part III - Fundamental Rights',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Articles 12–35 guarantee six categories of rights that are enforceable by the Supreme Court (Article 32) and High Courts (Article 226). These rights form the cornerstone of Indian democracy.',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...grouped.entries.map((entry) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Icon(_categoryIcon(entry.key),
                                  color: _categoryColor(entry.key), size: 22),
                              const SizedBox(width: 8),
                              Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: _categoryColor(entry.key),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...entry.value.map((article) => ArticleCard(
                              article: article,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ArticleDetailScreen(article: article),
                                ),
                              ),
                            )),
                        const SizedBox(height: 8),
                      ],
                    )),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

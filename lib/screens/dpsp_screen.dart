import 'package:flutter/material.dart';
import '../data/constitution_data.dart';
import '../widgets/article_card.dart';
import 'article_detail_screen.dart';

class DPSPScreen extends StatelessWidget {
  const DPSPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final part4 =
        constitutionParts.where((p) => p.partNumber == 'Part IV').toList();
    final articles = part4.isNotEmpty ? part4.first.articles : [];

    return Scaffold(
      appBar: AppBar(title: const Text('Directive Principles')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.purple.withOpacity(0.08),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.policy, color: Colors.purple),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Part IV - Directive Principles of State Policy',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Articles 36–51 are guidelines for the government when making laws and policies. '
                          'Inspired by the Irish Constitution, these are NOT enforceable by courts '
                          'but are "fundamental in the governance of the country" (Article 37). '
                          'They represent the socio-economic goals that India aspires to achieve.',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  color: Colors.amber.withOpacity(0.08),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.amber, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Key difference from Fundamental Rights: DPSPs are non-justiciable (you cannot go to court to enforce them). '
                            'However, they guide the government and many laws like MGNREGA, RTE, and minimum wage laws are based on DPSPs.',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.5,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...articles.map((article) => ArticleCard(
                      article: article,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ArticleDetailScreen(article: article),
                        ),
                      ),
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

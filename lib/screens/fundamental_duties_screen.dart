import 'package:flutter/material.dart';
import '../data/constitution_data.dart';

class FundamentalDutiesScreen extends StatelessWidget {
  const FundamentalDutiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Fundamental Duties')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.orange.withOpacity(0.08),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.flag, color: Colors.orange),
                            SizedBox(width: 8),
                            Text(
                              'Part IVA - Fundamental Duties',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Added by the 42nd Amendment (1976) on the recommendation of the Swaran Singh Committee. '
                          'Article 51A lists 11 duties every Indian citizen should follow. '
                          'While not directly enforceable by courts, they are morally binding and can be used by courts to interpret laws.',
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
                const SizedBox(height: 16),
                ...fundamentalDuties.asMap().entries.map((entry) {
                  final index = entry.key;
                  final duty = entry.value;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.orange.withOpacity(0.15),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      title: Text(
                        duty['number']!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                        ),
                      ),
                      subtitle: Text(
                        duty['duty']!,
                        style: const TextStyle(fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      childrenPadding: const EdgeInsets.all(16),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Full Text:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                duty['duty']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 14),
                              const Text(
                                'What it means:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                duty['explanation']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

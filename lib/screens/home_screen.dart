import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../data/constitution_data.dart';
import '../data/laws_data.dart';

import '../data/glossary_data.dart';
import 'constitution_explorer_screen.dart';
import 'laws_screen.dart';
import 'chatbot_screen.dart';
import 'landmark_cases_screen.dart';

import 'amendments_screen.dart';
import 'fundamental_rights_screen.dart';
import 'fundamental_duties_screen.dart';
import 'dpsp_screen.dart';
import 'glossary_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  int get _totalArticles {
    int count = 0;
    for (final part in constitutionParts) {
      count += part.articles.length;
    }
    return count;
  }

  int get _totalLawSections {
    int count = 0;
    for (final cat in indianLaws) {
      count += cat.sections.length;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 1200 ? 4 : (width > 800 ? 3 : 2);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_balance, color: AppTheme.gold, size: 36),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome to Nagrik',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                'Constitution & Laws for Every Citizen',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(0.85),
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '"We, the People of India" - The Constitution belongs to YOU. '
                      'Understand your rights, duties, and the laws that govern your nation.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        _StatBadge(
                          label: 'Articles',
                          value: '$_totalArticles+',
                          icon: Icons.article,
                        ),
                        _StatBadge(
                          label: 'Laws',
                          value: '$_totalLawSections+',
                          icon: Icons.gavel,
                        ),
                        _StatBadge(
                          label: 'Amendments',
                          value: '${keyAmendments.length}',
                          icon: Icons.history_edu,
                        ),
                        _StatBadge(
                          label: 'AI Chat',
                          value: '24/7',
                          icon: Icons.smart_toy,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Quick Access Grid
              Text(
                'Explore',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _QuickAccessCard(
                    icon: Icons.menu_book,
                    title: 'Constitution',
                    subtitle: '${constitutionParts.length} Parts',
                    color: Colors.blue,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ConstitutionExplorerScreen())),
                  ),
                  _QuickAccessCard(
                    icon: Icons.shield,
                    title: 'Fundamental Rights',
                    subtitle: 'Articles 12–35',
                    color: Colors.green,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FundamentalRightsScreen())),
                  ),
                  _QuickAccessCard(
                    icon: Icons.flag,
                    title: 'Fundamental Duties',
                    subtitle: '11 Citizen Duties',
                    color: Colors.orange,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FundamentalDutiesScreen())),
                  ),
                  _QuickAccessCard(
                    icon: Icons.policy,
                    title: 'DPSP',
                    subtitle: 'Directive Principles',
                    color: Colors.purple,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DPSPScreen())),
                  ),
                  _QuickAccessCard(
                    icon: Icons.gavel,
                    title: 'Laws & Acts',
                    subtitle: '${indianLaws.length} Categories',
                    color: Colors.red,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LawsScreen())),
                  ),
                  _QuickAccessCard(
                    icon: Icons.history_edu,
                    title: 'Amendments',
                    subtitle: '${keyAmendments.length} Key Changes',
                    color: Colors.teal,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const AmendmentsScreen())),
                  ),
                  _QuickAccessCard(
                    icon: Icons.balance,
                    title: 'Landmark Cases',
                    subtitle: '35+ Court Decisions',
                    color: Colors.indigo,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LandmarkCasesScreen())),
                  ),
                  _QuickAccessCard(
                    icon: Icons.woman,
                    title: 'Women\'s Laws',
                    subtitle: 'Rights & Helplines',
                    color: Colors.pink,
                    onTap: () => _showWomensLaws(context),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Preamble Section
              Text(
                'The Preamble',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.gold.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.auto_stories, color: AppTheme.gold, size: 32),
                      const SizedBox(height: 12),
                      SelectableText(
                        preambleText.trim(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.8,
                          color: theme.textTheme.bodyLarge?.color,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Women's Safety Laws & Helplines
              Text(
                'Women\'s Safety Laws & Helplines',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              ..._buildWomensSafety(context),

              const SizedBox(height: 28),

              // Landmark Court Decisions
              Text(
                'Landmark Court Decisions',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              ..._buildLandmarkDecisions(context),

              const SizedBox(height: 28),

              // Did You Know
              Text(
                'Did You Know?',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              ..._buildDidYouKnow(context),

              const SizedBox(height: 28),

              // Legal Glossary Preview
              Text(
                'Legal Terms to Know',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              ...legalGlossary.take(5).map((term) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                        child: Text(
                          term.term[0],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      title: Text(term.term,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(
                        term.definition,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
                      ),
                      trailing: term.hindiTerm.isNotEmpty
                          ? Text(
                              term.hindiTerm.split('(').first.trim(),
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.secondary,
                              ),
                            )
                          : null,
                    ),
                  )),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const GlossaryScreen())),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('View Full Glossary'),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showWomensLaws(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, controller) => Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              controller: controller,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text('Women\'s Rights & Safety',
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text('Key laws protecting women in India',
                    style: TextStyle(color: theme.textTheme.bodySmall?.color)),
                const SizedBox(height: 20),
                ..._womensLawsData.map((law) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Icon(Icons.shield, size: 18, color: Colors.pink.shade400),
                          const SizedBox(width: 8),
                          Expanded(child: Text(law['title']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
                        ]),
                        const SizedBox(height: 8),
                        Text(law['description']!, style: const TextStyle(fontSize: 13, height: 1.5)),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                Text('Emergency Helplines', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                ..._helplines.map((h) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  color: Colors.pink.shade50,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink.shade100,
                      child: Icon(Icons.phone, color: Colors.pink.shade700, size: 20),
                    ),
                    title: Text(h['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(h['number']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.call, color: Colors.pink),
                      onPressed: () => launchUrl(Uri.parse('tel:${h['number']}')),
                    ),
                  ),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  static final List<Map<String, String>> _womensLawsData = [
    {'title': 'Protection of Women from Domestic Violence Act, 2005', 'description': 'Provides protection to women from domestic violence including physical, emotional, verbal, sexual, and economic abuse. Women can get protection orders, residence orders, and monetary relief.'},
    {'title': 'Sexual Harassment of Women at Workplace (POSH) Act, 2013', 'description': 'Mandates every organization with 10+ employees to form an Internal Complaints Committee. Covers all women regardless of age or employment status.'},
    {'title': 'Dowry Prohibition Act, 1961', 'description': 'Prohibits giving or taking of dowry. Penalty: imprisonment up to 5 years and fine up to ₹15,000 or the amount of dowry, whichever is more.'},
    {'title': 'Section 354 IPC – Assault on Women', 'description': 'Criminalizes assault or use of criminal force on a woman with intent to outrage her modesty. Punishment: 1-5 years imprisonment.'},
    {'title': 'Section 498A IPC – Cruelty by Husband/Relatives', 'description': 'Protects married women from cruelty by husband or in-laws. Covers physical and mental cruelty. Cognizable and non-bailable offence.'},
    {'title': 'Maternity Benefit Act, 1961 (Amended 2017)', 'description': 'Provides 26 weeks paid maternity leave for first two children and 12 weeks for subsequent children. Applicable to all establishments with 10+ employees.'},
    {'title': 'Hindu Succession Act (Amendment 2005)', 'description': 'Gives daughters equal coparcenary rights as sons in ancestral property. Daughters have same rights to seek partition of the family property.'},
    {'title': 'The Prohibition of Child Marriage Act, 2006', 'description': 'Sets minimum age of marriage at 18 for women and 21 for men. Child marriages are voidable at the option of the contracting party who was a child.'},
  ];

  static final List<Map<String, String>> _helplines = [
    {'name': 'Women Helpline (All India)', 'number': '181'},
    {'name': 'Police Emergency', 'number': '112'},
    {'name': 'Women in Distress', 'number': '1091'},
    {'name': 'National Commission for Women', 'number': '7827-170-170'},
    {'name': 'Domestic Violence Helpline', 'number': '181'},
    {'name': 'Child Helpline', 'number': '1098'},
  ];

  List<Widget> _buildWomensSafety(BuildContext context) {
    final theme = Theme.of(context);
    final highlights = [
      {'icon': Icons.shield, 'title': 'Domestic Violence Act', 'subtitle': 'Protection from abuse at home'},
      {'icon': Icons.business, 'title': 'POSH Act 2013', 'subtitle': 'Safety at workplace'},
      {'icon': Icons.phone_in_talk, 'title': 'Helpline: 181', 'subtitle': 'Women helpline (24/7)'},
    ];
    return [
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: highlights.map((h) => SizedBox(
          width: (MediaQuery.of(context).size.width - 64) / 3,
          child: Card(
            child: InkWell(
              onTap: () => _showWomensLaws(context),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Icon(h['icon'] as IconData, color: Colors.pink, size: 24),
                    const SizedBox(height: 8),
                    Text(h['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12), textAlign: TextAlign.center),
                    const SizedBox(height: 4),
                    Text(h['subtitle'] as String, style: TextStyle(fontSize: 10, color: theme.textTheme.bodySmall?.color), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        )).toList(),
      ),
      const SizedBox(height: 8),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          onPressed: () => _showWomensLaws(context),
          icon: const Icon(Icons.arrow_forward, size: 16),
          label: const Text('View All Laws & Helplines'),
        ),
      ),
    ];
  }

  List<Widget> _buildLandmarkDecisions(BuildContext context) {
    final decisions = [
      {'case': 'Kesavananda Bharati v. State of Kerala (1973)', 'significance': 'Established the Basic Structure Doctrine - Parliament cannot alter the fundamental framework of the Constitution.'},
      {'case': 'Vishaka v. State of Rajasthan (1997)', 'significance': 'Laid down guidelines to prevent sexual harassment of women at workplace, leading to the POSH Act 2013.'},
      {'case': 'K.S. Puttaswamy v. Union of India (2017)', 'significance': 'Declared Right to Privacy as a fundamental right under Article 21 of the Constitution.'},
      {'case': 'Shreya Singhal v. Union of India (2015)', 'significance': 'Struck down Section 66A of the IT Act - landmark victory for free speech on the internet.'},
      {'case': 'Navtej Singh Johar v. Union of India (2018)', 'significance': 'Decriminalized Section 377 IPC - affirmed equal rights for LGBTQ+ persons.'},
    ];

    return [
      ...decisions.map((d) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.balance, color: Theme.of(context).colorScheme.primary, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(d['case']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        const SizedBox(height: 6),
                        Text(d['significance']!, style: const TextStyle(fontSize: 13, height: 1.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const LandmarkCasesScreen())),
          icon: const Icon(Icons.arrow_forward, size: 16),
          label: const Text('View All 35+ Landmark Cases'),
        ),
      ),
    ];
  }

  List<Widget> _buildDidYouKnow(BuildContext context) {
    final facts = [
      'The Indian Constitution is the longest written constitution in the world with 448 articles, 25 parts, and 12 schedules.',
      'Dr. B.R. Ambedkar is called the "Father of the Indian Constitution." He was the Chairman of the Drafting Committee.',
      'It took 2 years, 11 months, and 18 days to draft the Constitution. The Constituent Assembly had 299 members.',
      'The original Constitution was handwritten and calligraphed by Prem Behari Narain Raizada in both Hindi and English.',
      'India\'s Constitution has been amended 106 times as of 2023. The 42nd Amendment (1976) is called the "Mini-Constitution."',
    ];

    return facts
        .map((fact) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb, color: AppTheme.gold, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        fact,
                        style: const TextStyle(fontSize: 13, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatBadge({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.gold),
          const SizedBox(width: 6),
          Text(
            '$value $label',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.color
                      ?.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

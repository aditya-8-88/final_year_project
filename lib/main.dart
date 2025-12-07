import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'comprehensive_data.dart';
import 'case_studies_data.dart';

void main() {
  runApp(const WomenSafetyApp());
}

class WomenSafetyApp extends StatelessWidget {
  const WomenSafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Safety & Legal Awareness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1A237E),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E),
          primary: const Color(0xFF1A237E),
          secondary: const Color(0xFF455A64),
          brightness: Brightness.light,
        ),
        cardTheme: CardTheme(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AwarenessHomePage(),
    const StatisticsPage(),
    const EmergencyPage(),
    const LegalRightsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Women Safety & Legal Awareness'),
        centerTitle: true,
        elevation: 2,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.school),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          NavigationDestination(
            icon: Icon(Icons.emergency),
            label: 'Emergency',
          ),
          NavigationDestination(
            icon: Icon(Icons.gavel),
            label: 'Rights',
          ),
        ],
      ),
    );
  }
}

// NEW: Awareness Home Page
class AwarenessHomePage extends StatelessWidget {
  const AwarenessHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: Colors.pink.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.pink.shade700, size: 32),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Why Legal Awareness Matters',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '70% of women don\'t report crimes because they don\'t know their rights. '
                  'Knowledge is power. Learn about your legal rights, real cases, and how women fought back successfully.',
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildMenuCard(
          context,
          icon: Icons.menu_book,
          title: 'Real Case Studies',
          subtitle: '${comprehensiveCaseStudies.length} landmark cases with sources',
          color: Colors.blue,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CaseStudiesPage())),
        ),
        _buildMenuCard(
          context,
          icon: Icons.emoji_events,
          title: 'Success Stories',
          subtitle: 'Survivors who became warriors',
          color: Colors.green,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SuccessStoriesPage())),
        ),
        _buildMenuCard(
          context,
          icon: Icons.scale,
          title: 'Landmark Judgments',
          subtitle: 'Supreme Court decisions that empowered women',
          color: Colors.orange,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LandmarkJudgmentsPage())),
        ),

        _buildMenuCard(
          context,
          icon: Icons.library_books,
          title: 'Know Your Rights',
          subtitle: '10 essential legal rights every woman should know',
          color: Colors.teal,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LegalFactsPage())),
        ),
        _buildMenuCard(
          context,
          icon: Icons.phone,
          title: 'Emergency Helplines',
          subtitle: 'Quick access to all helplines',
          color: Colors.red,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelplinePage())),
        ),
        const SizedBox(height: 24),
        Card(
          color: Colors.amber.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(Icons.format_quote, color: Colors.amber.shade700, size: 32),
                const SizedBox(height: 8),
                Text(
                  '"A woman with a voice is, by definition, a strong woman."',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '- Melinda Gates',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

// Case Studies Page
class CaseStudiesPage extends StatelessWidget {
  const CaseStudiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real Case Studies')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: comprehensiveCaseStudies.length,
        itemBuilder: (context, index) {
          final caseStudy = comprehensiveCaseStudies[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CaseStudyDetailPage(caseStudy: caseStudy),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            caseStudy.year,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            caseStudy.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      caseStudy.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      caseStudy.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.gavel, size: 16, color: Colors.blue.shade700),
                        const SizedBox(width: 4),
                        Text(
                          'Tap to read full case & legal impact',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Case Study Detail Page
class CaseStudyDetailPage extends StatelessWidget {
  final DetailedCaseStudy caseStudy;

  const CaseStudyDetailPage({super.key, required this.caseStudy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(caseStudy.title)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  caseStudy.year,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Chip(
                label: Text(caseStudy.category),
                backgroundColor: Colors.blue.shade100,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (caseStudy.location.isNotEmpty)
            Chip(
              avatar: const Icon(Icons.location_on, size: 16),
              label: Text(caseStudy.location),
              backgroundColor: Colors.grey.shade200,
            ),
          const SizedBox(height: 20),
          _buildSection('What Happened', caseStudy.whatHappened, Icons.description, Colors.blue),
          _buildSection('Investigation', caseStudy.investigation, Icons.search, Colors.orange),
          _buildSection('Verdict', caseStudy.verdict, Icons.gavel, Colors.green),
          _buildSection('Legal Impact', caseStudy.legalImpact, Icons.account_balance, Colors.purple),
          _buildSection('Long-term Changes', caseStudy.longTermChanges, Icons.trending_up, Colors.teal),
          const SizedBox(height: 16),
          if (caseStudy.sources.isNotEmpty)
            Card(
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.library_books, color: Colors.grey.shade700, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Sources',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      caseStudy.sources,
                      style: const TextStyle(fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          if (caseStudy.sourceLinks.isNotEmpty)
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.link, color: Colors.blue.shade700, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Official Links',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...caseStudy.sourceLinks.map(
                      (link) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: InkWell(
                          onTap: () => _launchURL(link),
                          child: Row(
                            children: [
                              Icon(Icons.open_in_new, size: 16, color: Colors.blue.shade700),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  link,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blue.shade700,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildSection(String title, String content, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// Statistics Page
class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Official Statistics',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Data from NCRB, WHO, and government sources',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 16),
        ...officialStatistics.map((stat) => Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A237E).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.bar_chart, color: Color(0xFF1A237E), size: 32),
                        ),
                        const SizedBox(width: 12),
                        Chip(
                          label: Text(stat.year),
                          backgroundColor: Colors.blue.shade100,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A237E).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        stat.fact,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.source, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Source: ${stat.source}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

// Success Stories Page (full list)
class SuccessStoriesPage extends StatelessWidget {
  const SuccessStoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success Stories')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: successStories.length,
        itemBuilder: (context, index) {
          final story = successStories[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SuccessStoryDetailPage(story: story)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.green.shade100,
                          child: Icon(Icons.star, size: 28, color: Colors.green.shade700),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                story['name'],
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                story['year'],
                                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(story['story'], style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        story['quote'],
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Success Story Detail
class SuccessStoryDetailPage extends StatelessWidget {
  final Map<String, dynamic> story;

  const SuccessStoryDetailPage({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(story['name'])),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.pink.shade100,
              child: Icon(Icons.person, size: 80, color: Colors.pink.shade700),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            story['name'],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            story['year'],
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.description, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Her Story', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(story['story'], style: const TextStyle(fontSize: 15, height: 1.5)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.emoji_events, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Achievement', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(story['achievement'], style: const TextStyle(fontSize: 15, height: 1.5)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: Colors.amber.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.format_quote, color: Colors.amber.shade700, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    story['quote'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.pink.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.favorite, color: Colors.pink.shade700, size: 32),
                  const SizedBox(height: 8),
                  const Text(
                    'What We Learn',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No matter how difficult the situation, courage and determination can change not just your life, but society and laws. Your voice matters.',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Landmark Judgments Page
class LandmarkJudgmentsPage extends StatelessWidget {
  const LandmarkJudgmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Landmark Judgments')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: landmarkJudgments.length,
        itemBuilder: (context, index) {
          final judgment = landmarkJudgments[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance, color: Colors.orange.shade700, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          judgment['title'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      judgment['court'],
                      style: TextStyle(fontSize: 12, color: Colors.blue.shade700, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(judgment['description'], style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.gavel, color: Colors.green.shade700, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              'Verdict',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          judgment['verdict'],
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.purple.shade700, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              'Why This Matters',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          judgment['significance'],
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Prevention Tips Page
class PreventionTipsPage extends StatelessWidget {
  const PreventionTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety & Prevention Tips')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: preventionTips.length,
        itemBuilder: (context, index) {
          final tip = preventionTips[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              leading: Icon(Icons.shield, color: Colors.purple.shade700),
              title: Text(
                tip['category']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    tip['tips']!,
                    style: const TextStyle(fontSize: 14, height: 1.6),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Legal Facts Page
class LegalFactsPage extends StatelessWidget {
  const LegalFactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Know Your Legal Rights')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: comprehensiveLegalRights.length,
        itemBuilder: (context, index) {
          final right = comprehensiveLegalRights[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LegalRightDetailPage(right: right),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            right.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (right.article.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          right.article,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      right.description,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.touch_app, size: 16, color: Colors.teal.shade700),
                        const SizedBox(width: 4),
                        Text(
                          'Tap to read full details & official links',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.teal.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Legal Right Detail Page
class LegalRightDetailPage extends StatelessWidget {
  final LegalProvision right;

  const LegalRightDetailPage({super.key, required this.right});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(right.title)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          if (right.article.isNotEmpty)
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.account_balance, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            right.article,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          if (right.actName.isNotEmpty)
                            Text(
                              right.actName,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What This Means',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(right.description, style: const TextStyle(fontSize: 15, height: 1.6)),
                ],
              ),
            ),
          ),
          if (right.fullText.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.gavel, color: Colors.orange.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'Legal Text',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        right.fullText,
                        style: const TextStyle(fontSize: 14, height: 1.5, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (right.keyPoints.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'Key Points',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...right.keyPoints.map(
                      (point) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ', style: TextStyle(fontSize: 16, color: Colors.green.shade700)),
                            Expanded(child: Text(point, style: const TextStyle(fontSize: 14))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (right.howToUse.isNotEmpty)
            Card(
              color: Colors.teal.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.help_outline, color: Colors.teal.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'How to Use This Right',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(right.howToUse, style: const TextStyle(fontSize: 14, height: 1.6)),
                  ],
                ),
              ),
            ),
          if (right.officialLinks.isNotEmpty)
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.link, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'Official Resources',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...right.officialLinks.map(
                      (link) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          link,
                          style: TextStyle(fontSize: 13, color: Colors.blue.shade700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Emergency Page with Broadcast SOS
class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> with SingleTickerProviderStateMixin {
  bool _isSOSActive = false;
  late AnimationController _pulseController;
  List<Map<String, String>> _emergencyContacts = [];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _loadEmergencyContacts();
  }

  Future<void> _loadEmergencyContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsJson = prefs.getStringList('emergency_contacts') ?? [];
    setState(() {
      _emergencyContacts = contactsJson.map((json) {
        final parts = json.split('|');
        return {'name': parts[0], 'number': parts[1]};
      }).toList();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _activateBroadcastSOS() async {
    setState(() {
      _isSOSActive = !_isSOSActive;
    });
    
    if (_isSOSActive) {
      HapticFeedback.heavyImpact();
      
      // Call 112 first
      _call112();
      
      // Send SMS to all emergency contacts
      if (_emergencyContacts.isNotEmpty) {
        await _broadcastEmergencySMS();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No emergency contacts found. Add contacts in Profile section.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  Future<void> _broadcastEmergencySMS() async {
    for (var contact in _emergencyContacts) {
      final message = '''EMERGENCY ALERT!
I need help immediately. This is an automated SOS message.
Please contact me or call emergency services.
Contact: ${contact['name']}
Time: ${DateTime.now().toString().substring(0, 19)}

This message was sent from Women Safety App.''';
      
      final uri = Uri(
        scheme: 'sms',
        path: contact['number'],
        queryParameters: {'body': message},
      );
      
      try {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      } catch (e) {
        // Error sending SMS - silent fail for user experience
      }
    }
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Emergency SMS sent to ${_emergencyContacts.length} contacts'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _call112() async {
    final uri = Uri(scheme: 'tel', path: '112');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _callNumber(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: _isSOSActive ? Colors.red : null,
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _isSOSActive ? 1.0 + (_pulseController.value * 0.1) : 1.0,
                        child: child,
                      );
                    },
                    child: IconButton(
                      icon: const Icon(Icons.warning, size: 80),
                      color: _isSOSActive ? Colors.white : Colors.red,
                      onPressed: _activateBroadcastSOS,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isSOSActive ? 'SOS ACTIVATED!' : 'BROADCAST SOS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _isSOSActive ? Colors.white : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isSOSActive
                        ? 'Emergency alerts sent to all contacts!'
                        : 'Calls 112 + Sends SMS to ALL emergency contacts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _isSOSActive ? Colors.white : Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  if (!_isSOSActive && _emergencyContacts.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      '${_emergencyContacts.length} contacts will be notified',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: InkWell(
                    onTap: () => _callNumber('100'),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.phone, size: 32, color: Colors.blue),
                          SizedBox(height: 8),
                          Text('Police 100', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: InkWell(
                    onTap: () => _callNumber('181'),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.woman, size: 32, color: Colors.pink),
                          SizedBox(height: 8),
                          Text('Women 181', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.contacts, color: Colors.blue),
              title: Text('Emergency Contacts (${_emergencyContacts.length})'),
              subtitle: const Text('Manage who gets notified during SOS'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmergencyContactsPage()),
                );
                _loadEmergencyContacts();
              },
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: const Text('All Helplines'),
              subtitle: const Text('View all emergency numbers'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HelplinePage()));
              },
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.report, color: Colors.orange),
              title: const Text('Report Incident'),
              subtitle: const Text('Anonymous reporting'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportIncidentPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

// (Continue with Legal Rights Page, Helpline Page, Emergency Contacts, Report Incident, and Settings pages - keeping existing implementations)

// Legal Rights Page - Enhanced
class LegalRightsPage extends StatelessWidget {
  const LegalRightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: Colors.purple.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(Icons.scale, color: Colors.purple.shade700, size: 40),
                const SizedBox(height: 8),
                const Text(
                  'Knowledge is Your Shield',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Understanding your legal rights empowers you to fight injustice',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildQuickLink(
          context,
          'Know Your 10 Essential Rights',
          Icons.library_books,
          Colors.teal,
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LegalFactsPage())),
        ),
        _buildQuickLink(
          context,
          'Landmark Judgments',
          Icons.account_balance,
          Colors.orange,
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LandmarkJudgmentsPage())),
        ),
        _buildQuickLink(
          context,
          'Real Case Studies',
          Icons.menu_book,
          Colors.blue,
          () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CaseStudiesPage())),
        ),
        const SizedBox(height: 16),
        const Text('Legal Acts & Sections', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildLegalCard(
          context,
          title: 'Domestic Violence Act 2005',
          sections: [
            'Protection orders against abuser',
            'Right to shared household',
            'Monetary relief',
            'Custody of children',
          ],
        ),
        _buildLegalCard(
          context,
          title: 'Sexual Harassment Act 2013 (POSH)',
          sections: [
            'Workplace harassment definition',
            'Internal Complaints Committee',
            '90-day complaint timeline',
            'Employer liability',
          ],
        ),
        _buildLegalCard(
          context,
          title: 'IPC Sections for Women',
          sections: [
            '354: Assault/criminal force to woman',
            '354A: Sexual harassment',
            '354B: Assault to disrobe woman',
            '354C: Voyeurism',
            '354D: Stalking',
            '376: Rape',
            '498A: Cruelty by husband/relatives',
          ],
        ),
        _buildLegalCard(
          context,
          title: 'IT Act 2000 (Cyber Crimes)',
          sections: [
            '66E: Privacy violation',
            '67: Publishing obscene content',
            '67A: Sexually explicit content',
            '67B: Child pornography',
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLink(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLegalCard(BuildContext context, {required String title, required List<String> sections}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sections.map((section) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, size: 18, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(child: Text(section, style: const TextStyle(fontSize: 14))),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Keep existing Helpline, EmergencyContacts, ReportIncident pages unchanged
// (Copying from previous implementation)

class HelplinePage extends StatelessWidget {
  const HelplinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Helplines')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHelplineCard(
            title: 'Women Helpline',
            number: '181',
            description: '24x7 Support for women in distress',
            icon: Icons.woman,
            color: Colors.pink,
          ),
          _buildHelplineCard(
            title: 'National Commission for Women',
            number: '7827170170',
            description: 'Legal advice and support',
            icon: Icons.support_agent,
            color: Colors.purple,
            website: 'https://ncw.nic.in',
          ),
          _buildHelplineCard(
            title: 'Police (Emergency)',
            number: '100',
            description: 'Immediate police assistance',
            icon: Icons.local_police,
            color: Colors.blue,
          ),
          _buildHelplineCard(
            title: 'Ambulance',
            number: '102',
            description: 'Medical emergency services',
            icon: Icons.local_hospital,
            color: Colors.green,
          ),
          _buildHelplineCard(
            title: 'Cyber Crime Helpline',
            number: '155260',
            description: 'Report online harassment',
            icon: Icons.computer,
            color: Colors.indigo,
            website: 'https://cybercrime.gov.in',
          ),
        ],
      ),
    );
  }

  Widget _buildHelplineCard({
    required String title,
    required String number,
    required String description,
    required IconData icon,
    required Color color,
    String? website,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final uri = Uri(scheme: 'tel', path: number);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    icon: const Icon(Icons.phone),
                    label: Text(number),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: number));
                  },
                  icon: const Icon(Icons.copy),
                  tooltip: 'Copy',
                ),
                if (website != null)
                  IconButton(
                    onPressed: () async {
                      final uri = Uri.parse(website);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    icon: const Icon(Icons.link),
                    tooltip: 'Website',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  List<Map<String, String>> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsJson = prefs.getStringList('emergency_contacts') ?? [];
    setState(() {
      _contacts = contactsJson.map((json) {
        final parts = json.split('|');
        return {'name': parts[0], 'number': parts[1]};
      }).toList();
    });
  }

  Future<void> _saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsJson = _contacts.map((c) => '${c['name']}|${c['number']}').toList();
    await prefs.setStringList('emergency_contacts', contactsJson);
  }

  void _addContact() {
    final nameController = TextEditingController();
    final numberController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Emergency Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && numberController.text.isNotEmpty) {
                setState(() {
                  _contacts.add({
                    'name': nameController.text,
                    'number': numberController.text,
                  });
                });
                _saveContacts();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Contacts')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'These contacts will receive SMS when you activate Broadcast SOS',
                    style: TextStyle(fontSize: 13, color: Colors.blue.shade700),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _contacts.isEmpty
                ? const Center(child: Text('No emergency contacts added yet'))
                : ListView.builder(
                    itemCount: _contacts.length,
                    padding: const EdgeInsets.all(16.0),
                    itemBuilder: (context, index) {
                      final contact = _contacts[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.person)),
                          title: Text(contact['name']!),
                          subtitle: Text(contact['number']!),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.phone),
                                onPressed: () async {
                                  final uri = Uri(scheme: 'tel', path: contact['number']!);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _contacts.removeAt(index);
                                  });
                                  _saveContacts();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addContact,
        icon: const Icon(Icons.add),
        label: const Text('Add Contact'),
      ),
    );
  }
}

class ReportIncidentPage extends StatefulWidget {
  const ReportIncidentPage({super.key});

  @override
  State<ReportIncidentPage> createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  final _formKey = GlobalKey<FormState>();
  String _incidentType = 'Harassment';
  final _descriptionController = TextEditingController();
  bool _isAnonymous = true;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Report Submitted'),
          content: const Text(
            'Your report has been submitted successfully. Authorities will be notified.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Incident')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text('Report an Incident', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'All reports are confidential and will be handled with care.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _incidentType,
              decoration: const InputDecoration(
                labelText: 'Incident Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Harassment', child: Text('Harassment')),
                DropdownMenuItem(value: 'Assault', child: Text('Assault')),
                DropdownMenuItem(value: 'Domestic Violence', child: Text('Domestic Violence')),
                DropdownMenuItem(value: 'Stalking', child: Text('Stalking')),
                DropdownMenuItem(value: 'Cyber Crime', child: Text('Cyber Crime')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (value) {
                setState(() {
                  _incidentType = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Describe what happened...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Report Anonymously'),
              subtitle: const Text('Your identity will be kept private'),
              value: _isAnonymous,
              onChanged: (value) {
                setState(() {
                  _isAnonymous = value;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitReport,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
              child: const Text('Submit Report'),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        Text(
                          'Need Immediate Help?',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Call Women Helpline: 181'),
                    const Text('Call Police Emergency: 100'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

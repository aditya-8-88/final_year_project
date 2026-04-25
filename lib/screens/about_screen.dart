import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/storage_service.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About & Settings'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.info_outline), text: 'About'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AboutTab(),
          _SettingsTab(),
        ],
      ),
    );
  }
}

class _AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.account_balance,
                    size: 64, color: Color(0xFF1A237E)),
              ),
              const SizedBox(height: 16),
              Text(
                'Nagrik',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Constitution & Laws Explained for Every Citizen',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                'Version 2.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About This App',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Nagrik is a comprehensive legal education platform that makes the Indian Constitution, '
                        'laws, and legal rights accessible to every citizen. Powered by AI, '
                        'it provides simple explanations and an interactive chatbot to help you understand '
                        'your rights and the legal framework of India.',
                        style: TextStyle(fontSize: 14, height: 1.7),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Features',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      ...[
                        '450+ Constitution articles with simple explanations',
                        '9 major Indian laws with section-wise breakdown',
                        'AI-powered explanations',
                        'Interactive chatbot for legal queries',
                        'Women\'s safety laws & emergency helplines',
                        'Landmark court decisions',
                        'Legal glossary with Hindi translations',
                        'Bookmark system for quick reference',
                        'Dark mode support',
                        'Fully responsive - works on mobile, tablet, desktop',
                      ].map((f) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.check_circle,
                                    size: 16, color: Colors.green),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: Text(f,
                                        style: const TextStyle(
                                            fontSize: 13, height: 1.4))),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Disclaimer',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This app is for educational purposes only and does NOT constitute legal advice. '
                        'For legal matters, please consult a qualified legal professional. '
                        'The content is based on publicly available legal texts and may not reflect the most recent amendments.',
                        style: TextStyle(fontSize: 13, height: 1.6),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'B.Tech Final Year Project',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'GL Bajaj Institute of Technology and Management\n'
                        'Department of Computer Science & Engineering',
                        style: TextStyle(fontSize: 13, height: 1.5),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Technology Stack',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          'Flutter Web',
                          'Dart',
                          'Google Gemini API',
                          'NVIDIA NIM API',
                          'Netlify',
                          'Material Design 3',
                        ]
                            .map((t) => Chip(
                                  label: Text(t,
                                      style: const TextStyle(fontSize: 11)),
                                  visualDensity: VisualDensity.compact,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () => launchUrl(
                        Uri.parse('https://github.com/aditya-8-88/final_year_project')),
                    icon: const Icon(Icons.code, size: 18),
                    label: const Text('Source Code'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTab extends StatefulWidget {
  @override
  State<_SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<_SettingsTab> {
  final _geminiController = TextEditingController();
  final _nvidiaController = TextEditingController();
  final _githubController = TextEditingController();
  bool _geminiObscured = true;
  bool _nvidiaObscured = true;
  bool _githubObscured = true;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _loadKeys();
  }

  Future<void> _loadKeys() async {
    _geminiController.text = await StorageService.getGeminiApiKey();
    _nvidiaController.text = await StorageService.getNvidiaApiKey();
    _githubController.text = await StorageService.getGithubToken();
    if (mounted) setState(() {});
  }

  Future<void> _saveKeys() async {
    await StorageService.setGeminiApiKey(_geminiController.text.trim());
    await StorageService.setNvidiaApiKey(_nvidiaController.text.trim());
    await StorageService.setGithubToken(_githubController.text.trim());
    if (mounted) {
      setState(() => _saved = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _saved = false);
      });
    }
  }

  @override
  void dispose() {
    _geminiController.dispose();
    _nvidiaController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'AI API Keys',
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                'Enter your API keys to enable AI-powered explanations and chat.',
                style: TextStyle(
                  fontSize: 13,
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 24),

              // Gemini
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.auto_awesome,
                              color: Colors.blue, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Google Gemini API',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Get a free API key from Google AI Studio',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      TextButton(
                        onPressed: () => launchUrl(
                            Uri.parse('https://aistudio.google.com/apikey')),
                        child: const Text('Get API Key →',
                            style: TextStyle(fontSize: 12)),
                      ),
                      TextField(
                        controller: _geminiController,
                        obscureText: _geminiObscured,
                        decoration: InputDecoration(
                          labelText: 'Gemini API Key',
                          hintText: 'AIza...',
                          suffixIcon: IconButton(
                            icon: Icon(_geminiObscured
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => setState(
                                () => _geminiObscured = !_geminiObscured),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // NVIDIA
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.memory, color: Colors.green, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'NVIDIA NIM API',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Get an API key from NVIDIA Build',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            launchUrl(Uri.parse('https://build.nvidia.com/')),
                        child: const Text('Get API Key →',
                            style: TextStyle(fontSize: 12)),
                      ),
                      TextField(
                        controller: _nvidiaController,
                        obscureText: _nvidiaObscured,
                        decoration: InputDecoration(
                          labelText: 'NVIDIA API Key',
                          hintText: 'nvapi-...',
                          suffixIcon: IconButton(
                            icon: Icon(_nvidiaObscured
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => setState(
                                () => _nvidiaObscured = !_nvidiaObscured),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // GitHub Models
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.code, color: Colors.purple, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'GitHub Models (GPT-4o-mini)',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Free with any GitHub account. Generate a Personal Access Token (no special scopes needed).',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      TextButton(
                        onPressed: () => launchUrl(
                            Uri.parse('https://github.com/settings/tokens')),
                        child: const Text('Generate Token →',
                            style: TextStyle(fontSize: 12)),
                      ),
                      TextField(
                        controller: _githubController,
                        obscureText: _githubObscured,
                        decoration: InputDecoration(
                          labelText: 'GitHub Personal Access Token',
                          hintText: 'ghp_...',
                          suffixIcon: IconButton(
                            icon: Icon(_githubObscured
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => setState(
                                () => _githubObscured = !_githubObscured),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveKeys,
                  icon: Icon(_saved ? Icons.check : Icons.save),
                  label: Text(_saved ? 'Saved!' : 'Save API Keys'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: _saved ? Colors.green : null,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Card(
                color: Colors.amber.withOpacity(0.08),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.security, color: Colors.amber, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Your API keys are stored locally in your browser and are never sent to our servers. '
                          'They are only used to communicate directly with Google/NVIDIA/GitHub APIs.',
                          style: TextStyle(fontSize: 12, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

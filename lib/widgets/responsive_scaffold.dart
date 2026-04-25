import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../config/theme.dart';
import '../screens/home_screen.dart';
import '../screens/constitution_explorer_screen.dart';
import '../screens/laws_screen.dart';
import '../screens/chatbot_screen.dart';
import '../screens/chat_sessions_screen.dart';
import '../screens/search_screen.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/glossary_screen.dart';
import '../screens/about_screen.dart';
import '../screens/amendments_screen.dart';
import '../services/storage_service.dart';

class ResponsiveScaffold extends StatefulWidget {
  const ResponsiveScaffold({super.key});

  @override
  State<ResponsiveScaffold> createState() => ResponsiveScaffoldState();
}

class ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  int _selectedIndex = 0;

  static final List<_NavItem> _navItems = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.menu_book_rounded, label: 'Constitution'),
    _NavItem(icon: Icons.gavel_rounded, label: 'Laws'),
    _NavItem(icon: Icons.smart_toy_rounded, label: 'AI Assistant'),
  ];

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ConstitutionExplorerScreen();
      case 2:
        return const LawsScreen();
      case 3:
        return const ChatSessionsScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;
    final isMedium = width >= 600 && width < 900;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppTheme.gold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.account_balance, color: AppTheme.gold, size: 22),
            ),
            const SizedBox(width: 10),
            const Text(AppConstants.appName),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            tooltip: 'Bookmarks',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BookmarksScreen()),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'glossary':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const GlossaryScreen()));
                  break;
                case 'amendments':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AmendmentsScreen()));
                  break;
                case 'theme':
                  _toggleTheme();
                  break;
                case 'about':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AboutScreen()));
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'glossary',
                child: ListTile(
                  leading: Icon(Icons.book),
                  title: Text('Legal Glossary'),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'amendments',
                child: ListTile(
                  leading: Icon(Icons.history_edu),
                  title: Text('Amendments'),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'theme',
                child: ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text('Toggle Theme'),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'about',
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('About'),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              labelType: NavigationRailLabelType.all,
              leading: const SizedBox(height: 8),
              destinations: _navItems
                  .map((item) => NavigationRailDestination(
                        icon: Icon(item.icon),
                        label: Text(item.label),
                      ))
                  .toList(),
            ),
          if (isMedium)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              labelType: NavigationRailLabelType.selected,
              minWidth: 60,
              destinations: _navItems
                  .map((item) => NavigationRailDestination(
                        icon: Icon(item.icon),
                        label: Text(item.label),
                      ))
                  .toList(),
            ),
          if (isWide || isMedium)
            const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _buildPage(_selectedIndex),
            ),
          ),
        ],
      ),
      bottomNavigationBar: (!isWide && !isMedium)
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: _navItems
                  .map((item) => NavigationDestination(
                        icon: Icon(item.icon),
                        label: item.label,
                      ))
                  .toList(),
            )
          : null,
    );
  }

  void _toggleTheme() async {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;
    await StorageService.setDarkMode(!isDark);
    // Access the app-level ValueNotifier through the static reference
    final notifier = _findThemeNotifier();
    if (notifier != null) {
      notifier.value = !isDark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  ValueNotifier<ThemeMode>? _findThemeNotifier() {
    // Walk up to find NagrikApp's themeNotifier
    try {
      return NagrikAppTheme.themeNotifier;
    } catch (_) {
      return null;
    }
  }
}

class NagrikAppTheme {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

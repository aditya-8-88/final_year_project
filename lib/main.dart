import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'services/storage_service.dart';
import 'widgets/responsive_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();

  // Restore theme preference
  final isDark = await StorageService.isDarkMode();
  NagrikAppTheme.themeNotifier.value =
      isDark ? ThemeMode.dark : ThemeMode.light;

  runApp(const NagrikApp());
}

class NagrikApp extends StatelessWidget {
  const NagrikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: NagrikAppTheme.themeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Nagrik \u2014 Constitution & Laws for Every Citizen',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: const ResponsiveScaffold(),
        );
      },
    );
  }
}

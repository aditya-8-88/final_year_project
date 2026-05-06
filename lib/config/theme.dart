import 'package:flutter/material.dart';

class AppTheme {
  // Brand colors
  static const Color navy = Color(0xFF0D1B2A);
  static const Color deepBlue = Color(0xFF1B2838);
  static const Color royalBlue = Color(0xFF1A237E);
  static const Color gold = Color(0xFFD4A843);
  static const Color saffron = Color(0xFFFF9933);
  static const Color ashoka = Color(0xFF000080);
  static const Color parchment = Color(0xFFFAF3E0);

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: royalBlue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: royalBlue,
          primary: royalBlue,
          secondary: gold,
          tertiary: saffron,
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: navy,
          selectedIconTheme: const IconThemeData(color: gold),
          unselectedIconTheme: IconThemeData(color: Colors.white.withOpacity(0.6)),
          selectedLabelTextStyle: const TextStyle(
            color: gold,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: navy,
          indicatorColor: gold.withOpacity(0.2),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: gold);
            }
            return IconThemeData(color: Colors.white.withOpacity(0.6));
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                  color: gold, fontWeight: FontWeight.w600, fontSize: 12);
            }
            return TextStyle(
                color: Colors.white.withOpacity(0.6), fontSize: 11);
          }),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: royalBlue,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: royalBlue, width: 2),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey.shade100,
          selectedColor: royalBlue.withOpacity(0.15),
          labelStyle: const TextStyle(fontSize: 13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        useMaterial3: true,
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: royalBlue,
        scaffoldBackgroundColor: const Color(0xFF0A0E17),
        colorScheme: ColorScheme.fromSeed(
          seedColor: royalBlue,
          primary: const Color(0xFF5C6BC0),
          secondary: gold,
          tertiary: saffron,
          surface: const Color(0xFF141B2D),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D1117),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: const Color(0xFF141B2D),
          surfaceTintColor: Colors.transparent,
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: const Color(0xFF0D1117),
          selectedIconTheme: const IconThemeData(color: gold),
          unselectedIconTheme:
              IconThemeData(color: Colors.white.withOpacity(0.5)),
          selectedLabelTextStyle: const TextStyle(
            color: gold,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF0D1117),
          indicatorColor: gold.withOpacity(0.15),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: gold);
            }
            return IconThemeData(color: Colors.white.withOpacity(0.5));
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                  color: gold, fontWeight: FontWeight.w600, fontSize: 12);
            }
            return TextStyle(
                color: Colors.white.withOpacity(0.5), fontSize: 11);
          }),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF5C6BC0),
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1A2332),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2A3A4D)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2A3A4D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF5C6BC0), width: 2),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF1A2332),
          selectedColor: const Color(0xFF5C6BC0).withOpacity(0.3),
          labelStyle:
              const TextStyle(fontSize: 13, color: Colors.white70),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        useMaterial3: true,
      );
}

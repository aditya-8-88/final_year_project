import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';
import '../models/models.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Theme
  static Future<bool> isDarkMode() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getBool(AppConstants.themeKey) ?? false;
  }

  static Future<void> setDarkMode(bool value) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(AppConstants.themeKey, value);
  }

  // Compile-time env defaults (from --dart-define-from-file=.env)
  static const String _envGeminiKey = String.fromEnvironment('GEMINI_API_KEY');
  static const String _envNvidiaKey = String.fromEnvironment('NVIDIA_API_KEY');
  static const String _envGithubToken = String.fromEnvironment('GITHUB_TOKEN');
  static const String _envDefaultProvider = String.fromEnvironment('CHAT_PROVIDER_DEFAULT', defaultValue: 'gemini');

  static String get defaultProvider => _envDefaultProvider;

  // API Keys - SharedPreferences override > .env compile-time default
  static Future<String> getGeminiApiKey() async {
    _prefs ??= await SharedPreferences.getInstance();
    final stored = _prefs!.getString(AppConstants.geminiApiKeyPref) ?? '';
    return stored.isNotEmpty ? stored : _envGeminiKey;
  }

  static Future<void> setGeminiApiKey(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(AppConstants.geminiApiKeyPref, key);
  }

  static Future<String> getNvidiaApiKey() async {
    _prefs ??= await SharedPreferences.getInstance();
    final stored = _prefs!.getString(AppConstants.nvidiaApiKeyPref) ?? '';
    return stored.isNotEmpty ? stored : _envNvidiaKey;
  }

  static Future<void> setNvidiaApiKey(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(AppConstants.nvidiaApiKeyPref, key);
  }

  // GitHub Token
  static Future<String> getGithubToken() async {
    _prefs ??= await SharedPreferences.getInstance();
    final stored = _prefs!.getString(AppConstants.githubTokenPref) ?? '';
    return stored.isNotEmpty ? stored : _envGithubToken;
  }

  static Future<void> setGithubToken(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(AppConstants.githubTokenPref, key);
  }

  // Bookmarks
  static Future<List<Bookmark>> getBookmarks() async {
    _prefs ??= await SharedPreferences.getInstance();
    final raw = _prefs!.getStringList(AppConstants.bookmarksKey) ?? [];
    return raw.map((json) {
      final map = Map<String, String>.from(jsonDecode(json));
      return Bookmark.fromMap(map);
    }).toList();
  }

  static Future<void> addBookmark(Bookmark bookmark) async {
    final bookmarks = await getBookmarks();
    if (bookmarks.any((b) => b.id == bookmark.id)) return;
    bookmarks.add(bookmark);
    await _saveBookmarks(bookmarks);
  }

  static Future<void> removeBookmark(String id) async {
    final bookmarks = await getBookmarks();
    bookmarks.removeWhere((b) => b.id == id);
    await _saveBookmarks(bookmarks);
  }

  static Future<bool> isBookmarked(String id) async {
    final bookmarks = await getBookmarks();
    return bookmarks.any((b) => b.id == id);
  }

  static Future<void> _saveBookmarks(List<Bookmark> bookmarks) async {
    _prefs ??= await SharedPreferences.getInstance();
    final raw = bookmarks.map((b) => jsonEncode(b.toMap())).toList();
    await _prefs!.setStringList(AppConstants.bookmarksKey, raw);
  }

  // Quiz Scores
  static Future<Map<String, int>> getQuizScores() async {
    _prefs ??= await SharedPreferences.getInstance();
    final raw = _prefs!.getString(AppConstants.quizScoresKey);
    if (raw == null) return {};
    return Map<String, int>.from(jsonDecode(raw));
  }

  static Future<void> saveQuizScore(String category, int score) async {
    final scores = await getQuizScores();
    final existing = scores[category] ?? 0;
    if (score > existing) {
      scores[category] = score;
    }
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(AppConstants.quizScoresKey, jsonEncode(scores));
  }

  // Clear all data
  static Future<void> clearAll() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.clear();
  }
}

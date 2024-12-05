import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;

  //getters
  bool get isDarkTheme => _isDarkTheme;
  ThemeData get theme => _isDarkTheme ? ThemeData.dark() : ThemeData.light();

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveTheme(_isDarkTheme);
    notifyListeners();
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDark);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }
}

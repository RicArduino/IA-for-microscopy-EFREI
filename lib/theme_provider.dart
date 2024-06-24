import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = theme == ThemeData.dark();
    await prefs.setBool('darkMode', isDark);
    _themeData = theme;
    notifyListeners();
  }

  static Future<ThemeProvider> loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('darkMode') ?? false; // default to light mode
    ThemeData theme = isDark ? ThemeData.dark() : ThemeData.light();
    return ThemeProvider(theme);
  }
}

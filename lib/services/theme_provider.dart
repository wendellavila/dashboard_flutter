import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static late ThemeMode _themeMode;
  static late SharedPreferences prefs;

  ThemeProvider._();

  static Future<ThemeProvider> create() async {
    await loadPreferences();
    return ThemeProvider._();
  }

  static Future<void> loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    final bool? darkTheme = prefs.getBool('darkTheme');
    if (darkTheme == true) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
  }

  Future<void> switchTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      await prefs.setBool('darkTheme', true);
    } else {
      _themeMode = ThemeMode.light;
      await prefs.setBool('darkTheme', false);
    }
    notifyListeners();
  }

  ThemeMode getTheme() {
    return _themeMode;
  }
}

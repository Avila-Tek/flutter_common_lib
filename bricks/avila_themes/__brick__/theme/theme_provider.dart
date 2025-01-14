import 'package:flutter/material.dart';

/// This ThemeProvider class is used to manage the theme mode of the app.
/// It provides a method to toggle between light and dark mode.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeData get theme =>
      _themeMode == ThemeMode.light ? ThemeData.light() : ThemeData.dark();

  void toggleTheme({bool isDarkMode = false}) {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

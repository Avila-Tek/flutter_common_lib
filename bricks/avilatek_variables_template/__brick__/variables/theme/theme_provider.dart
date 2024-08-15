import 'package:flutter/material.dart';

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

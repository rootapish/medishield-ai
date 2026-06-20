import 'package:flutter/material.dart';
import 'package:medishield_ai/core/theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(dynamic preferencesService);

  ThemeMode _themeMode = ThemeMode.light; // Force light mode for this design

  ThemeMode get themeMode => _themeMode;

  bool get isDarkModeEnabled => false;

  ThemeData get lightTheme => AppTheme.light();
  ThemeData get darkTheme => AppTheme.dark();

  Future<void> initialize() async {
    // Keep it light mode for the pastel Stitch design
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  Future<void> setDarkModeEnabled(bool enabled) async {
    // Ignored, the design is currently light only
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    // Ignored
  }
}

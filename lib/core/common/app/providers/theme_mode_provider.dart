import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  bool _useDeviceSettings = false;
  bool _isDarkMode = false;

  bool get useDeviceSettings => _useDeviceSettings;

  bool get isDarkMode => _isDarkMode;

  set useDeviceSettings(bool value) {
    _useDeviceSettings = value;
  }

  set isDarkMode(bool value) {
    _isDarkMode = value;
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> initThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    useDeviceSettings = prefs.getBool('useDeviceSettings') ?? false;
    if (_useDeviceSettings) {
      _themeMode = ThemeMode.system;
      await prefs.setBool('useDeviceSettings', true);
    } else {
      await prefs.setBool('useDeviceSettings', false);
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      if (_isDarkMode) {
        _themeMode = ThemeMode.dark;
        await prefs.setBool('isDarkMode', true);
      } else {
        _themeMode = ThemeMode.light;
        await prefs.setBool('isDarkMode', true);
      }
    }
  }

  void set themeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }
}

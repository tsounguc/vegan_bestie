import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeProvider extends ChangeNotifier {
  var _themeMode = ThemeMode.light;
  var _useDeviceSettings = false;
  var _isDarkMode = false;

  ThemeModeProvider({required bool useDeviceSettings, required bool isDarkMode}) {
    _useDeviceSettings = useDeviceSettings;
    _isDarkMode = isDarkMode;
    if (_useDeviceSettings) {
      _themeMode = ThemeMode.system;
    } else if (_isDarkMode) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
  }

  ThemeModePreference prefs = ThemeModePreference();

  ThemeMode get themeMode => _themeMode;

  bool get useDeviceSettings => _useDeviceSettings;

  bool get isDarkMode => _isDarkMode;

  set useDeviceSettings(bool value) {
    _useDeviceSettings = value;
    prefs.setUseDeviceSettings(value);
    if (value) {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  set isDarkMode(bool value) {
    _isDarkMode = value;
    prefs.setDarkTheme(value);
    if (!_useDeviceSettings) {
      if (value) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    }
    notifyListeners();
  }
}

class ThemeModePreference {
  Future<void> setDarkTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  Future<void> setUseDeviceSettings(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useDeviceSettings', value);
  }

  Future<bool> getDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? false;
  }

  Future<bool> getUseDeviceSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('useDeviceSettings') ?? false;
  }
}

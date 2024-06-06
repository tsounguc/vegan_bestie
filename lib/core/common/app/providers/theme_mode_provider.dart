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

  // set themeMode(ThemeMode themeMode) {
  //   if (_themeMode != themeMode) _themeMode = themeMode;
  // }

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

// ThemeModeProvider() {
//   initThemeMode();
// }
//
// late ThemeMode _themeMode;
// late bool _useDeviceSettings;
// late bool _isDarkMode;
//
// ThemeModePreference _prefs = ThemeModePreference();
//
// bool get useDeviceSettings => _useDeviceSettings;
//
// bool get isDarkMode => _isDarkMode;
//
// set useDeviceSettings(bool value) {
//   _useDeviceSettings = value;
//   // notifyListeners();
// }
//
// set isDarkMode(bool value) {
//   _isDarkMode = value;
//
//   // notifyListeners();
// }
//
// ThemeMode get themeMode => _themeMode;
//
// Future<void> initThemeMode() async {
//   final prefs = await SharedPreferences.getInstance();
//   _useDeviceSettings = prefs.getBool('useDeviceSettings') ?? false;
//   if (_useDeviceSettings) {
//     _themeMode = ThemeMode.system;
//     await prefs.setBool('useDeviceSettings', true);
//     debugPrint('useDeviceSettings is true');
//   } else {
//     await prefs.setBool('useDeviceSettings', false);
//     debugPrint('useDeviceSettings is false');
//     _isDarkMode = prefs.getBool('isDarkMode') ?? false;
//
//     if (_isDarkMode) {
//       _themeMode = ThemeMode.dark;
//       debugPrint('isDarkMode is true');
//       await prefs.setBool('isDarkMode', true);
//     } else {
//       _themeMode = ThemeMode.light;
//       await prefs.setBool('isDarkMode', false);
//       debugPrint('isDarkMode is false');
//     }
//   }
//   notifyListeners();
// }
//
// Future<void> toggleThemeMode() async {
//   final prefs = await SharedPreferences.getInstance();
//   if (useDeviceSettings) {
//     _themeMode = ThemeMode.system;
//     await prefs.setBool('useDeviceSettings', true);
//     await prefs.setBool('isDarkMode', false);
//   } else if (!useDeviceSettings && isDarkMode) {
//     await prefs.setBool('useDeviceSettings', false);
//     await prefs.setBool('isDarkMode', true);
//     _themeMode = ThemeMode.dark;
//   } else {
//     await prefs.setBool('useDeviceSettings', false);
//     await prefs.setBool('isDarkMode', false);
//     _themeMode = ThemeMode.light;
//   }
//   notifyListeners();
// }
}

class ThemeModePreference {
  // static const THEME_STATUS = "THEMESTATUS";

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

// Future<bool> getTheme() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getBool(THEME_STATUS) ?? false;
// }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheveegan/core/services/service_locator.dart';

class ThemeSwitcher extends InheritedWidget {
  const ThemeSwitcher({
    required this.data,
    required super.child,
    super.key,
  });

  final _ThemeSwitcherWidgetState data;

  static _ThemeSwitcherWidgetState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeSwitcher>()?.data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }
}

class ThemeSwitcherWidget extends StatefulWidget {
  const ThemeSwitcherWidget({
    required this.initialDarkModeOn,
    required this.initialDeviceSettings,
    required this.child,
    super.key,
  });

  final bool initialDarkModeOn;
  final bool initialDeviceSettings;
  final Widget child;

  @override
  State<ThemeSwitcherWidget> createState() => _ThemeSwitcherWidgetState();
}

class _ThemeSwitcherWidgetState extends State<ThemeSwitcherWidget> {
  bool? _useDeviceSettings;
  bool? _isDarkModeOn;

  var _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool? get useDeviceSettings => _useDeviceSettings;

  bool? get isDarkModeOn => _isDarkModeOn;

  ThemeModePreference prefs = ThemeModePreference();

  void switchUseDeviceSettings({required bool value}) {
    setState(() {
      _useDeviceSettings = value;
      prefs.setUseDeviceSettings(value);
      _themeMode = ThemeMode.system;
    });
  }

  void switchDarkMode({required bool value}) {
    setState(() {
      _isDarkModeOn = value;
      prefs.setDarkTheme(value);
      if (false == _useDeviceSettings) {
        if (value) {
          _themeMode = ThemeMode.dark;
        } else {
          _themeMode = ThemeMode.light;
        }
      }
    });
  }

  @override
  void initState() {
    _useDeviceSettings = _useDeviceSettings ?? widget.initialDeviceSettings;
    _isDarkModeOn = _isDarkModeOn ?? widget.initialDarkModeOn;
    if (true == _useDeviceSettings) {
      _themeMode = ThemeMode.system;
    } else if (true == _isDarkModeOn) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isDarkModeOn = _isDarkModeOn ?? widget.initialDarkModeOn;
    _useDeviceSettings = _useDeviceSettings ?? widget.initialDeviceSettings;
    return ThemeSwitcher(
      data: this,
      child: widget.child,
    );
  }
}

class ThemeModePreference {
  Future<void> setDarkTheme(bool value) async {
    final prefs = serviceLocator<SharedPreferences>();
    await prefs.setBool('isDarkMode', value);
  }

  Future<void> setUseDeviceSettings(bool value) async {
    final prefs = serviceLocator<SharedPreferences>();
    await prefs.setBool('useDeviceSettings', value);
  }

  Future<bool> getDarkTheme() async {
    final prefs = serviceLocator<SharedPreferences>();
    return prefs.getBool('isDarkMode') ?? false;
  }

  Future<bool> getUseDeviceSettings() async {
    final prefs = serviceLocator<SharedPreferences>();
    return prefs.getBool('useDeviceSettings') ?? false;
  }
}

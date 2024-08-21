import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/app/providers/theme_inherited_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  static const String id = '/displayScreen';

  @override
  Widget build(BuildContext context) {
    final themeSwitcher = ThemeSwitcher.of(context)!;
    return Scaffold(
      appBar: AppBar(title: const Text('Display')),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35).copyWith(
            top: 15,
          ),
          children: [
            Card(
              surfaceTintColor: Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                leading: Icon(
                  Icons.phone_android,
                  color: context.theme.iconTheme.color,
                ),
                title: Text(
                  'Use Device Settings',
                  style: context.theme.textTheme.titleMedium,
                ),
                trailing: Switch(
                  value: themeSwitcher.useDeviceSettings ?? false,
                  thumbColor: MaterialStatePropertyAll(context.theme.primaryColor),
                  activeColor: Colors.green.shade400,
                  inactiveTrackColor: Colors.grey.shade300,
                  onChanged: (bool value) async {
                    themeSwitcher.switchUseDeviceSettings(value: value);
                    if (!value) {
                      final darkThemePrefs = await themeSwitcher.prefs.getDarkTheme();
                      themeSwitcher.switchDarkMode(value: darkThemePrefs);
                    }
                  },
                ),
              ),
            ),
            Card(
              surfaceTintColor: Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                leading: Icon(
                  themeSwitcher.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                  color:
                      themeSwitcher.themeMode == ThemeMode.light ? Colors.yellow : context.theme.iconTheme.color,
                ),
                title: Text(
                  themeSwitcher.themeMode == ThemeMode.dark ? 'DarkMode' : 'LightMode',
                  style: context.theme.textTheme.titleMedium,
                ),
                trailing: Switch(
                  value: false == themeSwitcher.useDeviceSettings && true == themeSwitcher.isDarkModeOn,
                  thumbColor: MaterialStatePropertyAll(context.theme.primaryColor),
                  activeColor: Colors.green.shade400,
                  inactiveTrackColor: Colors.grey.shade300,
                  onChanged: (bool value) {
                    if (false == themeSwitcher.useDeviceSettings) {
                      themeSwitcher.switchDarkMode(value: value);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

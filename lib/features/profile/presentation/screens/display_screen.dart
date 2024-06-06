import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/theme_mode_provider.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  static const String id = '/displayScreen';

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (
        BuildContext context,
        ThemeModeProvider provider,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(title: Text('Display')),
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
                      value: provider.useDeviceSettings,
                      thumbColor: MaterialStatePropertyAll(context.theme.primaryColor),
                      activeColor: Colors.green.shade400,
                      inactiveTrackColor: Colors.grey.shade300,
                      onChanged: (bool value) async {
                        provider.useDeviceSettings = value;
                        if (!value) {
                          provider.isDarkMode = await provider.prefs.getDarkTheme();
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
                      provider.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                      color: provider.themeMode == ThemeMode.light ? Colors.yellow : context.theme.iconTheme.color,
                    ),
                    title: Text(
                      provider.themeMode == ThemeMode.dark ? 'DarkMode' : 'LightMode',
                      style: context.theme.textTheme.titleMedium,
                    ),
                    trailing: Switch(
                      value: !provider.useDeviceSettings && provider.isDarkMode,
                      thumbColor: MaterialStatePropertyAll(context.theme.primaryColor),
                      activeColor: Colors.green.shade400,
                      inactiveTrackColor: Colors.grey.shade300,
                      onChanged: (bool value) {
                        if (!provider.useDeviceSettings) {
                          provider.isDarkMode = value;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

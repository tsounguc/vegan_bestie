import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/profile/presentation/refactors/user_card.dart';
import 'package:sheveegan/features/profile/presentation/screens/change_password_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/display_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String id = '/settingsPage';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // bool useDeviceSettings = false;
  // bool isDarkMode = false;

  // @override
  // void initState() {
  //   final mode = context.themeModeProvider.themeMode;
  //   if (mode == ThemeMode.system) {
  //     context.themeModeProvider.useDeviceSettings = true;
  //   } else if (mode == ThemeMode.dark) {
  //     context.themeModeProvider.isDarkMode = true;
  //   } else {
  //     context.themeModeProvider.isDarkMode = false;
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 35,
          ).copyWith(
            top: 15,
          ),
          children: [
            const UserCard(),
            const SizedBox(
              height: 40,
            ),
            Card(
              child: ListTile(
                // padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
                style: ListTileStyle.list,
                leading: Icon(
                  context.themeModeProvider.themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : context.themeModeProvider.themeMode == ThemeMode.system
                          ? Icons.phone_android
                          : Icons.light_mode,
                  color: context.themeModeProvider.themeMode == ThemeMode.light
                      ? Colors.yellow
                      : context.theme.iconTheme.color,
                ),
                title: Text(
                  'Display',
                  style: context.theme.textTheme.titleMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: context.theme.iconTheme.color,
                  size: 15,
                ),
                onTap: () => Navigator.of(context).pushNamed(
                  DisplayScreen.id,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                // padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
                style: ListTileStyle.list,
                leading: Icon(
                  Icons.lock_outline,
                  color: context.theme.iconTheme.color,
                ),
                title: Text(
                  'Change Password',
                  style: context.theme.textTheme.titleMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: context.theme.iconTheme.color,
                  size: 15,
                ),
                onTap: () => Navigator.of(context).pushNamed(
                  ChangePasswordScreen.id,
                  arguments: context.read<AuthBloc>(),
                ),
              ),
            ),
            SizedBox(
              height: context.height * 0.07,
            ),
            TextButton(
              onPressed: () {
                CoreUtils.displayDeleteAccountWarning(
                  context,
                  onDeletePressed: () {
                    Navigator.pop(context);
                    CoreUtils.showEnterPasswordDialog(context);
                  },
                );
              },
              child: Text(
                'Delete Account',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

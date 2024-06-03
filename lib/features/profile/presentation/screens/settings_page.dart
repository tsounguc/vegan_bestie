import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/theme_mode_provider.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/utils/core_utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String id = '/settingsPage';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // bool useDeviceSettings = false;
  // bool isDarkMode = false;

  @override
  void initState() {
    final mode = context.themeModeProvider.themeMode;
    if (mode == ThemeMode.system) {
      context.themeModeProvider.useDeviceSettings = true;
    } else if (mode == ThemeMode.dark) {
      context.themeModeProvider.isDarkMode = true;
    } else {
      context.themeModeProvider.isDarkMode = false;
    }
    super.initState();
  }

  void toggleTheme() {
    if (context.themeModeProvider.useDeviceSettings) {
      context.themeModeProvider.themeMode = ThemeMode.system;
    } else if (!context.themeModeProvider.useDeviceSettings &&
        context.themeModeProvider.isDarkMode) {
      context.themeModeProvider.themeMode = ThemeMode.dark;
    } else {
      context.themeModeProvider.themeMode = ThemeMode.light;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser!;
    final userImage =
        user.photoUrl == null || user.photoUrl!.isEmpty ? null : user.photoUrl;
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
            // ListTile(
            //   leading: const Icon(Icons.language),
            //   title: Text(
            //     'Language',
            //     style: TextStyle(
            //       fontSize: 16.sp,
            //       fontWeight: FontWeight.normal,
            //     ),
            //   ),
            //   subtitle: const Text(
            //     'English',
            //     style: TextStyle(fontWeight: FontWeight.normal),
            //   ),
            // ),

            // SizedBox(
            //   height: 20.h,
            // ),
            Card(
              surfaceTintColor: context.theme.colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 25,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      minRadius: 30,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: userImage != null
                          ? NetworkImage(
                              userImage,
                            )
                          : null,
                      child: userImage != null
                          ? null
                          : const Center(
                              child: Icon(
                                Icons.person,
                                size: 35,
                                color: Colors.black,
                              ),
                            ),
                      // backgroundImage:  userImage != null
                      //     ? NetworkImage(userImage!)
                      //     : AssetImage(kUserIconPath),
                    ),
                    const SizedBox(width: 20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                user.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            user.email,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
              child: Text(
                'Display',
                style: TextStyle(
                  fontSize: 16.sp,
                  // fontWeight: FontWeight.w600,
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
                  Icons.phone_android,
                  color: context.theme.iconTheme.color,
                ),
                title: Text(
                  'Use Device Settings',
                  style: context.theme.textTheme.titleMedium,
                ),
                trailing: Switch(
                  value: context.themeModeProvider.useDeviceSettings,
                  thumbColor:
                      MaterialStatePropertyAll(context.theme.primaryColor),
                  activeColor: Colors.green.shade400,
                  inactiveTrackColor: Colors.grey.shade300,
                  onChanged: (bool value) {
                    setState(() {
                      context.themeModeProvider.useDeviceSettings = value;
                    });
                    toggleTheme();
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
                  context.themeModeProvider.themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: context.theme.iconTheme.color,
                ),
                title: Text(
                  context.themeModeProvider.themeMode == ThemeMode.dark
                      ? 'DarkMode'
                      : 'LightMode',
                  style: context.theme.textTheme.titleMedium,
                ),
                trailing: Switch(
                  value: !context.themeModeProvider.useDeviceSettings &&
                      context.themeModeProvider.isDarkMode,
                  thumbColor:
                      MaterialStatePropertyAll(context.theme.primaryColor),
                  activeColor: Colors.green.shade400,
                  inactiveTrackColor: Colors.grey.shade300,
                  onChanged: (bool value) {
                    setState(() {
                      context.themeModeProvider.isDarkMode = value;
                    });
                    toggleTheme();
                  },
                ),
              ),
            ),
            SizedBox(
              height: context.height * 0.05,
            ),
            // const ListTile(
            //   title: Text(
            //     'Language',
            //     style: TextStyle(fontWeight: FontWeight.w600),
            //   ),
            //   subtitle: Text('English'),
            // ),
            LongButton(
                onPressed: () {
                  CoreUtils.displayDeleteAccountWarning(
                    context,
                    onDeletePressed: () {
                      Navigator.pop(context);
                      CoreUtils.showEnterPasswordDialog(context);
                    },
                  );
                },
                label: 'Delete Account')
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/profile/presentation/refactors/user_card.dart';
import 'package:sheveegan/features/profile/presentation/screens/change_email_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/change_password_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/contact_support_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/display_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String id = '/settingsPage';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final appLinkGoogle = 'https://play.google.com/store/apps/details?id=com.christiantsoungui.veganbestie';
  final appLinkAppleAppStore = 'https://apps.apple.com/be/app/vegan-bestie/id6448803152';
  final instagramLink = 'https://www.instagram.com/vgbestie';

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
            // Card(
            //   child: ListTile(
            //     // padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
            //     style: ListTileStyle.list,
            //     leading: Icon(
            //       context.themeModeProvider.themeMode == ThemeMode.dark
            //           ? Icons.dark_mode
            //           : context.themeModeProvider.themeMode == ThemeMode.system
            //               ? Icons.phone_android
            //               : Icons.light_mode,
            //       color: context.themeModeProvider.themeMode == ThemeMode.light
            //           ? Colors.yellow
            //           : context.theme.iconTheme.color,
            //     ),
            //     title: Text(
            //       'Display',
            //       style: context.theme.textTheme.titleMedium,
            //     ),
            //     trailing: Icon(
            //       Icons.arrow_forward_ios_outlined,
            //       color: context.theme.iconTheme.color,
            //       size: 15,
            //     ),
            //     onTap: () => Navigator.of(context).pushNamed(
            //       DisplayScreen.id,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Card(
              child: ListTile(
                style: ListTileStyle.list,
                leading: Icon(
                  Icons.email_outlined,
                  color: context.theme.iconTheme.color,
                ),
                title: Text(
                  'Change Email',
                  style: context.theme.textTheme.titleMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: context.theme.iconTheme.color,
                  size: 15,
                ),
                onTap: () => Navigator.of(context).pushNamed(
                  ChangeEmailScreen.id,
                  arguments: context.read<AuthBloc>(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
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
            const SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                style: ListTileStyle.list,
                leading: Icon(
                  Icons.contact_support_outlined,
                  color: context.theme.iconTheme.color,
                ),
                title: Text(
                  'Contact Support',
                  style: context.theme.textTheme.titleMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: context.theme.iconTheme.color,
                  size: 15,
                ),
                onTap: () => Navigator.of(context).pushNamed(
                  ContactSupportScreen.id,
                  arguments: context.read<AuthBloc>(),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Card(
              child: ListTile(
                  style: ListTileStyle.list,
                  leading: Icon(
                    FontAwesomeIcons.instagram,
                    color: context.theme.iconTheme.color,
                  ),
                  title: Text(
                    'Instagram',
                    style: context.theme.textTheme.titleMedium,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: context.theme.iconTheme.color,
                    size: 15,
                  ),
                  onTap: () {
                    launchUrl(Uri.parse(instagramLink));
                  }),
            ),

            const SizedBox(
              height: 40,
            ),
            Card(
              child: ListTile(
                  style: ListTileStyle.list,
                  leading: Icon(
                    FontAwesomeIcons.share,
                    color: context.theme.iconTheme.color,
                  ),
                  title: Text(
                    'Share Vegan Bestie',
                    style: context.theme.textTheme.titleMedium,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: context.theme.iconTheme.color,
                    size: 15,
                  ),
                  onTap: () async {
                    if (Platform.isAndroid) {
                      await FlutterShare.share(
                        title: 'Share App ',
                        linkUrl: appLinkGoogle,
                      );
                    }
                    if (Platform.isIOS) {
                      await FlutterShare.share(
                        title: 'Share App ',
                        linkUrl: appLinkAppleAppStore,
                      );
                    }
                  }),
            ),

            const SizedBox(
              height: 75,
            ),

            Card(
              child: ListTile(
                  style: ListTileStyle.list,
                  leading: Icon(
                    Icons.logout_outlined,
                    color: context.theme.iconTheme.color,
                  ),
                  title: Text(
                    'Log out',
                    style: context.theme.textTheme.titleMedium,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: context.theme.iconTheme.color,
                    size: 15,
                  ),
                  onTap: () async {
                    final navigator = Navigator.of(context);

                    context.savedProductsProvider.savedProductsList = null;
                    context.savedRestaurantsProvider.savedRestaurantsList = null;
                    context.restaurantsNearMeProvider.currentLocation = null;
                    context.restaurantsNearMeProvider.markers = null;
                    context.restaurantsNearMeProvider.restaurants = null;
                    context.userProvider.user = null;

                    await serviceLocator<FirebaseAuth>().signOut();
                    unawaited(
                      navigator.pushNamedAndRemoveUntil(
                        '/',
                        (route) => false,
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: context.height * 0.05,
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

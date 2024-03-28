import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Account',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_horiz_outlined),
          surfaceTintColor: Colors.white,
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: (_) {
            return [
              PopupMenuItem<void>(
                onTap: () => context.push(const Placeholder()),
                child: const PopupItem(
                  title: 'Edit Profile',
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF757C8E),
                  ),
                ),
              ),
              const PopupMenuItem<void>(
                // onTap: () => context.push(const Placeholder()),
                child: PopupItem(
                  title: 'Notifications',
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF757C8E),
                  ),
                ),
              ),
              const PopupMenuItem<void>(
                // onTap: () => context.push(const Placeholder()),
                child: PopupItem(
                  title: 'Help',
                  icon: Icon(
                    Icons.help_outline_outlined,
                    color: Color(0xFF757C8E),
                  ),
                ),
              ),
              PopupMenuItem<void>(
                height: 1,
                padding: EdgeInsets.zero,
                child: Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                  endIndent: 10,
                  indent: 10,
                ),
              ),
              PopupMenuItem<void>(
                onTap: () async {
                  final navigator = Navigator.of(context);
                  await serviceLocator<FirebaseAuth>().signOut();
                  unawaited(
                    navigator.pushNamedAndRemoveUntil(
                      '/',
                      (route) => false,
                    ),
                  );
                },
                child: const PopupItem(
                  title: 'Logout',
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

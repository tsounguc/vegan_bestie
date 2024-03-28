import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final user = provider.user;
        final image = user?.photoUrl == null || user!.photoUrl!.isEmpty ? null : provider.user!.photoUrl!;
        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: image != null ? NetworkImage(image) : null,
              child: user?.photoUrl != null
                  ? null
                  : const Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
            ),
            Text(
              user?.name ?? 'No User',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ],
        );
      },
    );
  }
}

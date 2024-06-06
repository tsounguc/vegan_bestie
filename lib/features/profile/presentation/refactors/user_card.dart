import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/profile/presentation/screens/edit_profile_screen.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser!;
    final userImage = user.photoUrl == null || user.photoUrl!.isEmpty ? null : user.photoUrl;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        EditProfileScreen.id,
        arguments: context.read<AuthBloc>(),
      ),
      child: Card(
        surfaceTintColor: context.theme.colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
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
              const SizedBox(width: 10),
              SizedBox(
                width: context.width * 0.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        // fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      user.email,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: context.width * 0.12,
                child: const Icon(Icons.edit_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/profile/presentation/screens/edit_profile_screen.dart';

class ProfileHeaderBottom extends StatelessWidget {
  const ProfileHeaderBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: context.theme.cardTheme.color?.withOpacity(0.93),
            border: const Border(
              right: BorderSide(color: Colors.black12),
              left: BorderSide(color: Colors.black12),
              bottom: BorderSide(color: Colors.black12),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.r),
              bottomRight: Radius.circular(25.r),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                if (user?.bio != null && user!.bio!.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        user.bio!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          // color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                if (user?.bio != null && user!.bio!.isNotEmpty)
                  SizedBox(
                    height: 20.h,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                        EditProfileScreen.id,
                        arguments: serviceLocator<AuthBloc>(),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: context.theme.textTheme.titleSmall,
                      ),
                      // icon: Icon(
                      //   Icons.edit_outlined,
                      //   color: Colors.black,
                      // ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/media_resources.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';

class ProfilePictureScreen extends StatelessWidget {
  const ProfilePictureScreen({super.key});

  static const String id = '/profilePictureScreen';

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    final image = user?.photoUrl == null || user!.photoUrl!.isEmpty ? null : user.photoUrl!;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ProfilePicDeleted) {
          CoreUtils.showSnackBar(context, 'Profile picture deleted');
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: CustomBackButton(),
          centerTitle: true,
          actions: [
            if (user?.photoUrl != null && user!.photoUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(DeleteProfilePicEvent(user: user));
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 14.sp,
                      // color: Theme.of(context).textTheme.titleLarge?.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
          ],
        ),
        body: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 150),
          child: Center(
            child: Hero(
              tag: 'profilePic',
              child: image != null
                  ? CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, percentage) {
                        return const LoadingPage(
                          backgroundColor: Colors.black,
                        );
                      },
                      errorWidget: (context, error, child) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 150),
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 400,
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 400,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

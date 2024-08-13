import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/enums/update_user.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/profile/presentation/widgets/edit_profile_form.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String id = '/editProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final veganStatusController = TextEditingController();
  File? pickedImage;

  Future<void> showImagePickerOptions(BuildContext context) async {
    await showModalBottomSheet<void>(
      backgroundColor: context.theme.colorScheme.background,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 10,
              ),
              leading: Icon(
                Icons.camera_alt_outlined,
                color: context.theme.iconTheme.color,
              ),
              title: Text(
                'Camera',
                style: TextStyle(
                  color: context.theme.textTheme.titleSmall?.color,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await CoreUtils.getImageFromCamera();
                if (image != null) {
                  setState(() {
                    pickedImage = image;
                  });
                }
              },
            ),
            SizedBox(
              child: Divider(
                color: Colors.grey.shade300,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 10,
              ),
              leading: Icon(
                Icons.image_outlined,
                color: context.theme.iconTheme.color,
              ),
              title: Text(
                'Gallery',
                style: TextStyle(
                  color: context.theme.textTheme.titleSmall?.color,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await CoreUtils.pickImageFromGallery();
                if (image != null) {
                  setState(() {
                    pickedImage = image;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  bool get nameChanged => context.currentUser?.name.trim() != fullNameController.text.trim();

  bool get emailChanged => emailController.text.trim().isNotEmpty;

  bool get bioChanged => context.currentUser?.bio?.trim() != bioController.text.trim();

  bool get veganStatusChanged => context.currentUser?.veganStatus?.trim() != veganStatusController.text.trim();

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged
      // && !passwordChanged
      &&
      !bioChanged &&
      !veganStatusChanged &&
      !imageChanged;

  @override
  void initState() {
    fullNameController.text = context.currentUser!.name.trim();
    bioController.text = context.currentUser!.bio?.trim() ?? '';
    veganStatusController.text = context.currentUser!.veganStatus?.trim() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void saveChanges(BuildContext context) {
    if (nothingChanged) Navigator.pop(context);
    final bloc = context.read<AuthBloc>();
    if (nameChanged) {
      bloc.add(
        UpdateUserEvent(
          action: UpdateUserAction.displayName,
          userData: fullNameController.text.trim(),
        ),
      );
    }
    if (emailChanged) {
      bloc.add(
        UpdateUserEvent(
          action: UpdateUserAction.email,
          userData: emailController.text.trim(),
        ),
      );
    }
    if (imageChanged) {
      bloc.add(
        UpdateUserEvent(
          action: UpdateUserAction.photoUrl,
          userData: pickedImage,
        ),
      );
    }
    if (bioChanged) {
      bloc.add(
        UpdateUserEvent(
          action: UpdateUserAction.bio,
          userData: bioController.text.trim(),
        ),
      );
    }
    if (veganStatusChanged) {
      bloc.add(
        UpdateUserEvent(
          action: UpdateUserAction.veganStatus,
          userData: veganStatusController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
          CoreUtils.showSnackBar(
            context,
            'Profile updated successfully',
          );
          // context.pop();
        } else if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          // backgroundColor: Colors.white,
          appBar: AppBar(
            // surfaceTintColor: Colors.white,
            title: const Text('Edit Profile'),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Builder(
                    builder: (context) {
                      final user = context.currentUser!;
                      final userImage = user.photoUrl == null || user.photoUrl!.isEmpty ? null : user.photoUrl;
                      return Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SizedBox(height: 25.h),
                          Container(
                            height: context.height * 0.2,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    fit: BoxFit.contain,
                                  )
                                : userImage != null
                                    ? Image.network(userImage, fit: BoxFit.contain)
                                    : const Center(
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.grey,
                                          size: 150,
                                        ),
                                      ),
                          ),
                          Positioned(
                            child: Container(
                              height: context.height * 0.2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async => showImagePickerOptions(context),
                            icon: Icon(
                              (pickedImage != null || user.photoUrl != null) ? Icons.edit : Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  EditProfileForm(
                    fullNameController: fullNameController,
                    emailController: emailController,
                    veganStatusController: veganStatusController,
                    // passwordController: passwordController,
                    // oldPasswordController: oldPasswordController,
                    bioController: bioController,
                  ),
                  const SizedBox(height: 30),
                  StatefulBuilder(
                    builder: (context, refresh) {
                      fullNameController.addListener(() => refresh(() {}));
                      emailController.addListener(() => refresh(() {}));
                      // passwordController.addListener(() => refresh(() {}));
                      bioController.addListener(() => refresh(() {}));
                      veganStatusController.addListener(() => refresh(() {}));
                      return state is AuthLoading
                          ? const Center(child: CircularProgressIndicator())
                          : LongButton(
                              onPressed: nothingChanged ? null : () => saveChanges(context),
                              label: 'Save',
                              backgroundColor: nothingChanged
                                  ? Colors.grey
                                  : Theme.of(context).buttonTheme.colorScheme?.primary,
                              textColor: Colors.white,
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

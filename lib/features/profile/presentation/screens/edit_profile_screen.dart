import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
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
  File? pickedImage;

  // final passwordController = TextEditingController();
  // final oldPasswordController = TextEditingController();

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  bool get nameChanged => context.currentUser?.name.trim() != fullNameController.text.trim();

  bool get emailChanged => emailController.text.trim().isNotEmpty;

  // bool get passwordChanged => passwordController.text.trim().isNotEmpty;

  bool get bioChanged => context.currentUser?.bio?.trim() != bioController.text.trim();

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged
      // && !passwordChanged
      &&
      !bioChanged &&
      !imageChanged;

  @override
  void initState() {
    fullNameController.text = context.currentUser!.name.trim();
    bioController.text = context.currentUser!.bio?.trim() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    // passwordController.dispose();
    // oldPasswordController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void saveChanges(BuildContext context) {
    if (nothingChanged) Navigator.pop(context);
    final bloc = context.read<AuthBloc>();
    // if (passwordChanged) {
    //   if (oldPasswordController.text.isEmpty) {
    //     CoreUtils.showSnackBar(
    //       context,
    //       'Please enter your old password',
    //     );
    //     return;
    //   }
    //   bloc.add(
    //     UpdateUserEvent(
    //       action: UpdateUserAction.password,
    //       userData: jsonEncode({
    //         'oldPassword': oldPasswordController.text.trim(),
    //         'newPassword': passwordController.text.trim(),
    //       }),
    //     ),
    //   );
    // }
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          Navigator.of(context).pop();
          CoreUtils.showSnackBar(
            context,
            'Profile updated successfully',
          );
        } else if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            leading: const CustomBackButton(
              color: Colors.black,
              // color: Theme.of(context).primaryColor,
            ),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                // color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                // fontSize: 24,
              ),
            ),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    fit: BoxFit.contain,
                                  )
                                : userImage != null
                                    ? Image.network(userImage, fit: BoxFit.contain)
                                    : Image.asset(kUserIconPath, fit: BoxFit.contain),
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
                            onPressed: pickImage,
                            icon: Icon(
                              (pickedImage != null || user.photoUrl != null) ? Icons.edit : Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 30),
                  EditProfileForm(
                    fullNameController: fullNameController,
                    emailController: emailController,
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

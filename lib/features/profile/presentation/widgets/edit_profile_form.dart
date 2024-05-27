import 'package:flutter/material.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/features/profile/presentation/widgets/edit_profile_form_field.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.fullNameController,
    required this.emailController,
    // required this.passwordController,
    // required this.oldPasswordController,
    required this.bioController,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;

  // final TextEditingController passwordController;
  // final TextEditingController oldPasswordController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
          fieldTitle: 'NAME',
          controller: fullNameController,
          hintText: context.currentUser!.name,
        ),
        EditProfileFormField(
          fieldTitle: 'EMAIL',
          controller: emailController,
          hintText: context.currentUser!.email.obscureEmail,
        ),
        // EditProfileFormField(
        //   fieldTitle: 'CURRENT PASSWORD',
        //   controller: oldPasswordController,
        //   hintText: '********',
        // ),
        // StatefulBuilder(
        //   builder: (_, setState) {
        //     oldPasswordController.addListener(
        //       () => setState(() {}),
        //     );
        //     return EditProfileFormField(
        //       fieldTitle: 'NEW PASSWORD',
        //       controller: passwordController,
        //       hintText: '********',
        //       readOnly: oldPasswordController.text.isEmpty,
        //     );
        //   },
        // ),
        EditProfileFormField(
          fieldTitle: 'BIO',
          controller: bioController,
          borderRadius: BorderRadius.circular(20),
          minLines: 4,
          maxLines: null,
          textInputAction: TextInputAction.newline,
        ),
      ],
    );
  }
}

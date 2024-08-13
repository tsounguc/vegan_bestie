import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/widgets/vegan_status_text_field.dart';
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
    required this.veganStatusController,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;

  // final TextEditingController passwordController;
  // final TextEditingController oldPasswordController;
  final TextEditingController bioController;
  final TextEditingController veganStatusController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
          fieldTitle: 'Name',
          controller: fullNameController,
          hintText: context.currentUser!.name,
        ),
        VeganStatusTextField(
          fieldTitle: 'Vegan Status',
          controller: veganStatusController,
        ),
        EditProfileFormField(
          fieldTitle: 'Email',
          controller: emailController,
          hintText: context.currentUser!.email.obscureEmail,
        ),
        EditProfileFormField(
          fieldTitle: 'Bio',
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

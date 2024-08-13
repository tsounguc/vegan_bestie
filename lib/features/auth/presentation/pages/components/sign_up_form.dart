import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';
import 'package:sheveegan/core/common/widgets/vegan_status_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.fullNameController,
    required this.veganStatusController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    this.onConfirePasswordFieldSubmitted,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController veganStatusController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final void Function(String)? onConfirePasswordFieldSubmitted;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          IField(
            controller: widget.fullNameController,
            hintText: 'Full Name',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 25),
          VeganStatusTextField(
            fieldTitle: '',
            controller: widget.veganStatusController,
          ),
          // const SizedBox(height: 25),
          IField(
            controller: widget.emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 25),
          IField(
            controller: widget.passwordController,
            hintText: 'Password',
            obscureText: obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscurePassword = !obscurePassword;
              }),
              icon: Icon(
                obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 25),
          IField(
            controller: widget.confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: obscureConfirmPassword,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.send,
            onFieldSubmitted: widget.onConfirePasswordFieldSubmitted,
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscureConfirmPassword = !obscureConfirmPassword;
              }),
              icon: Icon(
                obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
            ),
            overrideValidator: true,
            validator: (value) {
              if (value != widget.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

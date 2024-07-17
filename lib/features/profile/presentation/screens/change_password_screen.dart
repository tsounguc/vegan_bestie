import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/enums/update_user.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/profile/presentation/widgets/change_password_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String id = '/changePasswordScreen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  bool get passwordChanged => passwordController.text.trim().isNotEmpty;

  bool get nothingChanged => !passwordChanged;

  void saveChanges(BuildContext context) {
    if (nothingChanged) Navigator.pop(context);
    final bloc = context.read<AuthBloc>();
    if (passwordChanged) {
      if (oldPasswordController.text.isEmpty) {
        CoreUtils.showSnackBar(
          context,
          'Please enter your old password',
        );
        return;
      }
      bloc.add(
        UpdateUserEvent(
          action: UpdateUserAction.password,
          userData: jsonEncode({
            'oldPassword': oldPasswordController.text.trim(),
            'newPassword': passwordController.text.trim(),
          }),
        ),
      );
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          Navigator.of(context).pop();
          CoreUtils.showSnackBar(
            context,
            'Password changed successfully',
          );
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
            title: const Text('Change Password'),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                children: [
                  Builder(
                    builder: (context) {
                      return ChangePasswordForm(
                        oldPasswordController: oldPasswordController,
                        passwordController: passwordController,
                        onPasswordFieldSubmitted: (_) => saveChanges(context),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  StatefulBuilder(
                    builder: (context, refresh) {
                      passwordController.addListener(() => refresh(() {}));
                      return state is AuthLoading
                          ? const Center(child: CircularProgressIndicator())
                          : LongButton(
                              onPressed: nothingChanged ? null : () => saveChanges(context),
                              label: 'Submit',
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

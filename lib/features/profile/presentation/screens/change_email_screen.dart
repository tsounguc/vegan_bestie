import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/enums/update_user.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/profile/presentation/widgets/edit_profile_form_field.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  static const String id = '/changeEmailScreen';

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final emailController = TextEditingController();

  bool get emailChanged => emailController.text.trim().isNotEmpty;

  bool get nothingChanged => !emailChanged;

  void saveChanges(BuildContext context) {
    if (nothingChanged) Navigator.pop(context);
    final bloc = context.read<AuthBloc>();
    if (emailChanged) {
      bloc.add(
        UpdateUserEvent(
          action: UpdateUserAction.email,
          userData: emailController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
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
            'Email changed successfully',
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
            title: const Text('Change Email'),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                children: [
                  Builder(
                    builder: (context) {
                      return EditProfileFormField(
                        fieldTitle: 'Email',
                        controller: emailController,
                        hintText: context.currentUser!.email.obscureEmail,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  StatefulBuilder(
                    builder: (context, refresh) {
                      emailController.addListener(() => refresh(() {}));
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/auth/presentation/pages/components/sign_in_form.dart';
import 'package:sheveegan/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:sheveegan/features/auth/presentation/pages/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String id = '/signInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    FirebaseAuth.instance.currentUser?.reload();
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SignInWithEmailAndPasswordEvent(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as UserModel);
            Navigator.pushReplacementNamed(context, '/');
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 35,
                ).copyWith(
                  top: 15,
                ),
                children: [
                  VeganBestieLogoWidget(
                    size: 50.r,
                    showText: false,
                  ),
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 32.sp,
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign in to your account',
                          style: TextStyle(
                            fontSize: 14.r,
                            color: context.theme.textTheme.bodyMedium?.color,
                            // color: Colors.grey.shade800,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SignInForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                    onPasswordFieldSubmitted: (_) => signIn(context),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ForgotPasswordScreen.id,
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14.r,
                          fontWeight: FontWeight.w600,
                          color: context.theme.primaryColor,
                          // decoration: TextDecoration.underline,
                          // decorationColor: context.theme.primaryColor,
                          // decorationThickness: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  if (state is AuthLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    LongButton(
                      onPressed: () => signIn(context),
                      label: 'Sign In',
                    ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SignUpScreen.id,
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 14.r, color: context.theme.textTheme.bodyMedium?.color,
                          // color: Colors.grey.shade800,
                        ),
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              fontSize: 14.r,
                              fontWeight: FontWeight.w600,
                              color: context.theme.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: context.theme.primaryColor,
                              decorationThickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

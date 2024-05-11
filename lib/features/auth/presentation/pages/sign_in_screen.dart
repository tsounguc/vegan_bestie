import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:sheveegan/home_page.dart';

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
            Navigator.pushReplacementNamed(context, HomePage.id);
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
                  top: 0,
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
                            color: Colors.grey.shade800,
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
                          fontSize: 14.r,
                          color: Colors.grey.shade800,
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
                          )
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

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   static const String id = '/loginPage';
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool isPasswordHidden = true;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       onPopInvoked: (didPop) {},
//       canPop: false,
//       child: BlocBuilder<AuthBloc, AuthState>(
//         builder: (context, state) {
//           if (state is AuthLoading) {
//             _passwordController.clear();
//             return const LoadingPage();
//           }
//           return GestureDetector(
//             onTap: () {
//               FocusScope.of(context).requestFocus(FocusNode());
//             },
//             child: Scaffold(
//               key: _scaffoldKey,
//               resizeToAvoidBottomInset: false,
//               backgroundColor: Theme.of(context).colorScheme.background,
//               appBar: AppBar(
//                 elevation: 0,
//                 backgroundColor: Theme.of(context).colorScheme.background,
//                 leading: !Navigator.of(context).canPop()
//                     ? null
//                     : IconButton(
//                         color: Colors.white,
//                         icon: const Icon(Icons.arrow_back_ios),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//               ),
//               body: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         const Center(
//                           child: Text(
//                             'Login',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 60,
//                         ),
//                         const AuthErrorMessageWidget(),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         TextFormField(
//                           controller: _emailController,
//                           validator: (emailText) {
//                             if (emailText!.isEmpty) {
//                               return 'Please enter a valid email';
//                             }
//                             return null;
//                           },
//                           keyboardType: TextInputType.emailAddress,
//                           textInputAction: TextInputAction.next,
//                           onEditingComplete: () {
//                             FocusScope.of(context).nextFocus();
//                           },
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white70,
//                             labelText: 'Email',
//                             labelStyle: TextStyle(
//                               color: Colors.green.shade900,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             floatingLabelStyle: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 10,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         TextFormField(
//                           controller: _passwordController,
//                           validator: (passwordText) {
//                             if (passwordText!.length < 6) {
//                               return 'Password must have at lease 6 characters';
//                             }
//                             return null;
//                           },
//                           obscureText: isPasswordHidden,
//                           textInputAction: TextInputAction.send,
//                           onEditingComplete: () {
//                             FocusScope.of(context).unfocus();
//                             if (_formKey.currentState!.validate()) {
//                               BlocProvider.of<AuthBloc>(
//                                 context,
//                               ).add(
//                                 SignInWithEmailAndPasswordEvent(
//                                   email: _emailController.text.trim(),
//                                   password: _passwordController.text.trim(),
//                                 ),
//                               );
//                             }
//                           },
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white70,
//                             focusColor: Colors.white,
//                             labelText: 'Password',
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isPasswordHidden = !isPasswordHidden;
//                                 });
//                               },
//                               icon: Icon(
//                                 !isPasswordHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//                               ),
//                             ),
//                             suffixIconColor: Colors.green.shade900,
//                             // floatingLabelBehavior: FloatingLabelBehavior.always,
//                             // hintText: "Enter your Password",
//                             // hintStyle: TextStyle(
//                             //   color: Colors.green.shade900,
//                             //   fontSize: 14.sp,
//                             // ),
//                             labelStyle: TextStyle(
//                               color: Colors.green.shade900,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             floatingLabelStyle: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.green.shade900,
//                               ),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 10,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 8),
//                               child: TextButton(
//                                 onPressed: () {
//                                   // `TODO`(Login-Handler): Push to ForgotPasswordScreen
//                                   // BlocProvider.of<AuthBloc>(
//                                   //   context,
//                                   // ).gotToForgotPasswordPage();
//                                 },
//                                 child: const Text(
//                                   'Forgot Password?',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         LongButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               BlocProvider.of<AuthBloc>(
//                                 context,
//                               ).add(
//                                 SignInWithEmailAndPasswordEvent(
//                                   email: _emailController.text.trim(),
//                                   password: _passwordController.text.trim(),
//                                 ),
//                               );
//                             }
//                           },
//                           text: 'Log In',
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               height: 1,
//                               width: MediaQuery.of(context).size.width * 0.25,
//                               color: Colors.grey,
//                             ),
//                             const Text(
//                               'Or Continue With',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             Container(
//                               height: 1,
//                               width: MediaQuery.of(context).size.width * 0.25,
//                               color: Colors.grey,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         const OtherAuthOptions(
//                           pageId: LoginPage.id,
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Don't have an account?",
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // `TODO`(Login-Handler): Push to SignUpScreen
//                                 if (!Navigator.canPop(context)) {
//                                   // BlocProvider.of<AuthBloc>(
//                                   //   context,
//                                   // ).goToRegister();
//                                 } else {
//                                   // BlocProvider.of<AuthBloc>(
//                                   //   context,
//                                   // ).goToRegister();
//                                   // Navigator.of(
//                                   //   context,
//                                   // ).pushNamed(RegistrationPage.id);
//                                 }
//                               },
//                               child: const Text(
//                                 'Register now',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   decoration: TextDecoration.underline,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             TextButton(
//                               onPressed: () {
//                                 // `TODO`(Login-Handler): Continue as guest
//                                 // BlocProvider.of<AuthBloc>(
//                                 //   context,
//                                 // ).continueAsGuest();
//                               },
//                               child: const Text(
//                                 'Continue as a guest',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

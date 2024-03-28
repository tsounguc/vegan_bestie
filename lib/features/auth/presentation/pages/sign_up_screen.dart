import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/auth/presentation/pages/components/sign_up_form.dart';
import 'package:sheveegan/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:sheveegan/home_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String id = '/signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedUp) {
            context.read<AuthBloc>().add(
                  CreateUserAccountEvent(
                    fullName: fullNameController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                );
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(
                  state.user as UserModel,
                );
            Navigator.pushReplacementNamed(context, HomePage.id);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28.r,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Sign up for an account',
                    style: TextStyle(
                      fontSize: 14.r,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          SignInScreen.id,
                        );
                      },
                      child: Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 14.r),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SignUpForm(
                    fullNameController: fullNameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    formKey: formKey,
                  ),
                  const SizedBox(height: 30),
                  if (state is AuthLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    LongButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        FirebaseAuth.instance.currentUser?.reload();
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                CreateUserAccountEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  fullName: fullNameController.text.trim(),
                                ),
                              );
                        }
                      },
                      label: 'Sign Up',
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sheveegan/core/common/screens/loading/loading.dart';
// import 'package:sheveegan/core/common/widgets/auth_error_message_widget.dart';
// import 'package:sheveegan/core/common/widgets/buttons.dart';
// import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
// import 'package:sheveegan/features/auth/presentation/pages/components/other_auth_options.dart';
//
// class RegistrationPage extends StatefulWidget {
//   const RegistrationPage({super.key});
//
//   static const String id = '/signUpPage';
//
//   @override
//   State<RegistrationPage> createState() => _RegistrationPageState();
// }
//
// class _RegistrationPageState extends State<RegistrationPage> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   bool isPasswordObscured = true;
//   bool isConfirmPasswordObscured = true;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is AuthLoading) {
//           _passwordController.clear();
//           _confirmPasswordController.clear();
//           return const LoadingPage();
//         }
//         return Container(
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.background,
//           ),
//           child: GestureDetector(
//             onTap: () {
//               FocusScope.of(context).requestFocus(FocusNode());
//             },
//             child: Scaffold(
//               key: _scaffoldKey,
//               resizeToAvoidBottomInset: false,
//               backgroundColor: Colors.transparent,
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
//                             'Register to get started',
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
//                           controller: _nameController,
//                           validator: (userNameText) {
//                             if (userNameText!.isEmpty) {
//                               return 'Please enter name';
//                             }
//                             return null;
//                           },
//                           keyboardType: TextInputType.name,
//                           textInputAction: TextInputAction.next,
//                           onEditingComplete: () {
//                             FocusScope.of(_formKey.currentContext!).nextFocus();
//                           },
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white70,
//                             labelText: 'Name',
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
//                             FocusScope.of(_formKey.currentContext!).nextFocus();
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
//                           obscureText: isPasswordObscured,
//                           textInputAction: TextInputAction.next,
//                           onFieldSubmitted: (String value) => FocusScope.of(
//                             _formKey.currentContext!,
//                           ).nextFocus(),
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white70,
//                             labelText: 'Password',
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isPasswordObscured = !isPasswordObscured;
//                                 });
//                               },
//                               icon: Icon(
//                                 !isPasswordObscured ? Icons.visibility_off : Icons.visibility,
//                               ),
//                             ),
//                             suffixIconColor: Colors.green.shade900,
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
//                               borderSide: const BorderSide(
//                                 color: Colors.white,
//                               ),
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
//                           controller: _confirmPasswordController,
//                           validator: (confirmPasswordText) {
//                             if (_confirmPasswordController.text.trim().isEmpty) {
//                               return 'Please enter password';
//                             } else if (_confirmPasswordController.text.length < 6) {
//                               return 'Password must have at lease 6 characters';
//                             } else if (_confirmPasswordController.text.trim() != _passwordController.text.trim()) {
//                               return "Password doesn't match";
//                             }
//                             return null;
//                           },
//                           obscureText: isConfirmPasswordObscured,
//                           keyboardType: TextInputType.text,
//                           textInputAction: TextInputAction.send,
//                           onEditingComplete: () {
//                             FocusScope.of(_formKey.currentContext!).unfocus();
//                             if (_formKey.currentState!.validate()) {
//                               BlocProvider.of<AuthBloc>(
//                                 context,
//                               ).add(
//                                 CreateUserAccountEvent(
//                                   fullName: _nameController.text.trim(),
//                                   email: _emailController.text.trim(),
//                                   password: _passwordController.text.trim(),
//                                 ),
//                               );
//                             }
//                           },
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white70,
//                             labelText: 'Confirm Password',
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isConfirmPasswordObscured = !isConfirmPasswordObscured;
//                                 });
//                               },
//                               icon: Icon(
//                                 !isConfirmPasswordObscured ? Icons.visibility_off : Icons.visibility,
//                               ),
//                             ),
//                             suffixIconColor: Colors.green.shade900,
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
//                           height: 40,
//                         ),
//                         LongButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               BlocProvider.of<AuthBloc>(
//                                 context,
//                               ).add(
//                                 CreateUserAccountEvent(
//                                   fullName: _nameController.text.trim(),
//                                   email: _emailController.text.trim(),
//                                   password: _passwordController.text.trim(),
//                                 ),
//                               );
//                             }
//                           },
//                           text: 'Register',
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
//                               'Or Register with',
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
//                           pageId: RegistrationPage.id,
//                         ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Already have an account?',
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // `TODO`(Login-Handler): Push to LoginPage
//                                 // BlocProvider.of<AuthBloc>(
//                                 //   context,
//                                 // ).goToLoginPage();
//                               },
//                               child: const Text(
//                                 'Login',
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
//                           height: 40,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

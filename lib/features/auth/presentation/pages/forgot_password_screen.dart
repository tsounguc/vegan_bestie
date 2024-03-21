import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/auth/presentation/pages/sign_in_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String id = '/forgotPasswordScreen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is ForgotPasswordSent) {
            CoreUtils.showSnackBar(context, 'A link was sent to your email');
            Navigator.pushReplacementNamed(context, SignInScreen.id);
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
                    'Forgotten password',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28.r,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Provide your email and we will send you '
                          'a link to reset your password',
                          style: TextStyle(
                            fontSize: 14.r,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  Form(
                    key: formKey,
                    child: IField(
                      controller: emailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
                                ForgotPasswordEvent(
                                  email: emailController.text.trim(),
                                ),
                              );
                        }
                      },
                      label: 'Reset Password',
                    ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Go back',
                        style: TextStyle(fontSize: 14.r),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sheveegan/core/common/widgets/auth_error_message_widget.dart';
// import 'package:sheveegan/core/common/widgets/buttons.dart';
// import 'package:sheveegan/core/resources/colors.dart';
//
// class ForgotPasswordPage extends StatelessWidget {
//   ForgotPasswordPage({super.key});
//
//   static const String id = '/forgotPasswordPage';
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: gradientStartColor),
//       child: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(FocusNode());
//         },
//         child: Scaffold(
//           key: _scaffoldKey,
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Theme.of(context).colorScheme.background,
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Theme.of(context).colorScheme.background,
//             leading: !Navigator.of(context).canPop()
//                 ? null
//                 : IconButton(
//                     color: Colors.white,
//                     icon: const Icon(Icons.arrow_back_ios),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 40),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Center(
//                       child: Text(
//                         'Reset Password',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 60,
//                     ),
//                     const AuthErrorMessageWidget(),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextFormField(
//                       controller: _emailController,
//                       validator: (emailText) {
//                         if (emailText!.isEmpty) {
//                           return 'Please enter a valid email';
//                         }
//                         return null;
//                       },
//                       keyboardType: TextInputType.emailAddress,
//                       textInputAction: TextInputAction.send,
//                       onEditingComplete: () {
//                         FocusScope.of(_formKey.currentContext!).unfocus();
//                       },
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white70,
//                         labelText: 'Email',
//                         labelStyle: TextStyle(
//                           color: Colors.green.shade900,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         floatingLabelStyle: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.white),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     LongButton(onPressed: () {}, text: 'Send Code'),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 40,
//                         vertical: 10,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             'Remember password?',
//                             style: TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               // BlocProvider.of<AuthCubit>(
//                               //   context,
//                               // ).goToLoginPage();
//                             },
//                             child: const Text(
//                               'Login',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

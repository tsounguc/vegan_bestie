import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/auth_error_message_widget.dart';
import '../../../../core/buttons.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/loading.dart';
import '../auth_cubit/auth_cubit.dart';
import 'auth_page.dart';
import 'components/other_auth_options.dart';
import 'forgot_password.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  static const String id = "/loginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _email, _password;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isPasswordObscured = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            _passwordController.clear();
            return LoadingPage();
          }
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.background,
                leading: !Navigator.of(context).canPop()
                    ? null
                    : IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        AuthErrorMessageWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: (emailText) {
                            if (emailText!.isEmpty) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          // onChanged: (input) => _email = input,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          validator: (passwordText) {
                            if (passwordText!.length < 6) {
                              return 'Password must have at lease 6 characters';
                            }
                            return null;
                          },
                          // onChanged: (input) => _password = input,
                          autofocus: false,
                          obscureText: isPasswordObscured,
                          textInputAction: TextInputAction.send,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).signInWithEmailAndPassword(
                                  _emailController.text.trim(), _passwordController.text.trim());
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            focusColor: Colors.white,
                            labelText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordObscured = !isPasswordObscured;
                                });
                              },
                              icon: Icon(!isPasswordObscured ? Icons.visibility_off : Icons.visibility),
                            ),
                            suffixIconColor: Colors.green.shade900,
                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                            // hintText: "Enter your Password",
                            // hintStyle: TextStyle(
                            //   color: Colors.green.shade900,
                            //   fontSize: 14.sp,
                            // ),
                            labelStyle: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green.shade900),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthCubit>(context).gotToForgotPasswordPage();
                                  // Navigator.of(context).pushNamed(ForgotPasswordPage.id);
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        LongButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).signInWithEmailAndPassword(
                                  _emailController.text.trim(), _passwordController.text.trim());
                            }
                          },
                          text: "Log In",
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * 0.25,
                              color: Colors.grey,
                            ),
                            Text(
                              "Or Continue With",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * 0.25,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        OtherAuthOptions(
                          pageId: LoginPage.id,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (!Navigator.canPop(context)) {
                                  debugPrint("Register now can't pop");
                                  BlocProvider.of<AuthCubit>(context).goToRegister();
                                  // Navigator.of(context).pushReplacementNamed(SignUpPage.id);
                                } else {
                                  debugPrint("Register now can pop");
                                  BlocProvider.of<AuthCubit>(context).goToRegister();
                                  Navigator.of(context).pushNamed(RegistrationPage.id);
                                }
                              },
                              child: Text(
                                "Register now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context).continueAsGuest();
                              },
                              child: Text(
                                "Continue as a guest",
                                style: TextStyle(
                                  color: Colors.white,
                                  // decoration: TextDecoration.underline,
                                  // decorationThickness: 5,
                                  // fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

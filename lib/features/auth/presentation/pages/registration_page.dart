import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheveegan/core/constants/colors.dart';
import 'package:sheveegan/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:sheveegan/features/auth/presentation/pages/login_page.dart';
import 'package:sheveegan/home_page.dart';

import '../../../../core/auth_error_message_widget.dart';
import '../../../../core/buttons.dart';
import '../../../../core/loading.dart';
import 'auth_page.dart';
import 'components/other_auth_options.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = "/signUpPage";

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? _userName, _email, _password, _confirmPassword;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          _passwordController.clear();
          _confirmPasswordController.clear();
          return LoadingPage();
        }
        return Container(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
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
                            "Register to get started",
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
                          controller: _nameController,
                          validator: (userNameText) {
                            if (userNameText!.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          // onChanged: (input) => _userName = input,
                          autofocus: false,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(_formKey.currentContext!).nextFocus();
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            labelText: "Name",
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
                            FocusScope.of(_formKey.currentContext!).nextFocus();
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
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (String value) => FocusScope.of(_formKey.currentContext!).nextFocus(),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
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
                          controller: _confirmPasswordController,
                          validator: (confirmPasswordText) {
                            if (_confirmPasswordController.text.trim().isEmpty) {
                              return "Please enter password";
                            } else if (_confirmPasswordController.text.length < 6) {
                              return "Password must have at lease 6 characters";
                            } else if (_confirmPasswordController.text.trim() != _passwordController.text.trim()) {
                              return 'Password doesn\'t match';
                            }
                            return null;
                          },
                          // onChanged: (input) => _confirmPassword = input,
                          autofocus: false,
                          obscureText: isConfirmPasswordObscured,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.send,
                          onEditingComplete: () {
                            FocusScope.of(_formKey.currentContext!).unfocus();
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).createUserAccount(_nameController.text.trim(),
                                  _emailController.text.trim(), _passwordController.text.trim());
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            labelText: "Confirm Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordObscured = !isConfirmPasswordObscured;
                                });
                              },
                              icon: Icon(!isConfirmPasswordObscured ? Icons.visibility_off : Icons.visibility),
                            ),
                            suffixIconColor: Colors.green.shade900,
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
                          height: 40,
                        ),
                        LongButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).createUserAccount(_nameController.text.trim(),
                                  _emailController.text.trim(), _passwordController.text.trim());
                            }
                          },
                          text: "Register",
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
                              "Or Register with",
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
                          pageId: RegistrationPage.id,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context).goToLoginPage();
                              },
                              child: Text(
                                "Login",
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
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheveegan/core/constants/colors.dart';
import 'package:sheveegan/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:sheveegan/features/auth/presentation/pages/login_page.dart';
import 'package:sheveegan/home_page.dart';

import '../../../../core/auth_error_message_widget.dart';
import '../../../../core/loading.dart';
import 'auth_page.dart';

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 25.0, bottom: 50.0, right: 8.0),
                        child: Text(
                          "Register to get started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AuthErrorMessageWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
                        child: TextFormField(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                        child: TextFormField(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
                        child: TextFormField(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 7.5),
                        child: TextFormField(
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
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                        child: Container(
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            color: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context).createUserAccount(_nameController.text.trim(),
                                    _emailController.text.trim(), _passwordController.text.trim());
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.green.shade900,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Row(
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
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.facebookF,
                                    // size: 35,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  // icon: Icon(
                                  //   FontAwesomeIcons.google,
                                  //   color: Colors.black,
                                  //   // size: 35,
                                  // ),
                                  icon: Image.network(
                                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.apple,
                                  // size: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 40,
                        ),
                        child: Row(
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
                      ),
                    ],
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

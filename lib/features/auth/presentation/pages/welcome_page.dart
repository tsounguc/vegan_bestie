import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/buttons.dart';
import 'package:sheveegan/core/constants/colors.dart';

import '../../../../core/constants/strings.dart';
import '../../../../themes/app_theme.dart';
import '../auth_cubit/auth_cubit.dart';

class WelcomePage extends StatelessWidget {
  // const WelcomePage({Key? key}) : super(key: key);
  static const String id = "/welcomePage";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 150),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.appTitle,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.lightPrimaryColor),

                      // style: TextStyle(
                      //   color: titleTextColorOne,
                      //   fontSize: 36.sp,
                      //   fontWeight: FontWeight.w800,
                      //   fontFamily: 'cursive',
                      // ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    LongButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).goToLoginPage();
                      },
                      text: "Login",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    LongButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).goToRegister();
                      },
                      text: "Register",
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

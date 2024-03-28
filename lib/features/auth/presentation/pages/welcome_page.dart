import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/themes/app_theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const String id = '/welcomePage';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {},
      canPop: false,
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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 150),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.appTitle,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: AppTheme.lightPrimaryColor,
                          ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    LongButton(
                      onPressed: () {
                        // BlocProvider.of<AuthCubit>(context).goToLoginPage();
                      },
                      label: 'Login',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LongButton(
                      onPressed: () {
                        // BlocProvider.of<AuthCubit>(context).goToRegister();
                      },
                      label: 'Register',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        // BlocProvider.of<AuthCubit>(context).continueAsGuest();
                      },
                      child: const Text(
                        'Continue as a guest',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

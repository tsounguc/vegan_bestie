import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error.dart';
import '../../../../core/loading.dart';
import '../../../../home_page.dart';
import '../auth_cubit/auth_cubit.dart';
import 'login_page.dart';
import 'welcome_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<AuthCubit>(context).currentUser();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).currentUser();
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return LoadingPage();
        }
        if (state is AuthErrorState) {
          return ErrorPage();
        }
        if (state is LoggedInState) {
          return HomePage();
        }
        if (state is SignedOutState) {
          return LoginPage();
        }
        if (state is AuthInitialState) {
          return WelcomePage();
        }
        return Container();
      },
    );
  }
}

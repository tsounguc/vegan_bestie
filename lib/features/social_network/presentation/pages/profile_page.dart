import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/loading.dart';
import '../../../auth/presentation/auth_cubit/auth_cubit.dart';
import '../../../restaurants/presentation/pages/componets/number_button.dart';
import 'components/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  static const String id = "/profilePage";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is LoggedInState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(),
                SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.currentUser.name!,
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      state.currentUser.email!,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "VEGAN",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberButton(
                        value: '0',
                        text: 'Posts',
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      NumberButton(
                        value: '50',
                        text: 'Besties',
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      NumberButton(
                        value: '30',
                        text: 'Following',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "I'm a Cameroonian born and raised in Chad. US Citizen. Friendly vegan atheist.",
                      // state.currentUser.bio,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          );
        }
        return LoadingPage();
      },
    );
  }
}

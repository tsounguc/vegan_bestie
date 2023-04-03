import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/presentation/auth_cubit/auth_cubit.dart';
import '../features/social_network/presentation/pages/profile_page.dart';
import 'custom_circle_avatar.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is LoggedInState) {
          return SafeArea(
            child: Drawer(
              backgroundColor: Theme.of(context).colorScheme.background,
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProfilePage.id);
                      },
                      child: DrawerHeader(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          // image: DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage(
                          //         "https://media.licdn.com/dms/image/C5603AQFq3ET1ktm-qQ/profile-displayphoto-shrink_800_800/0/1588221581935?e=2147483647&v=beta&t=LDoGtLa7sXY1VQhXrnPVSAMmoCNQIw_qDA79H6wmNeY")),
                          // gradient: LinearGradient(
                          //   colors: <Color>[
                          //     Theme.of(context).colorScheme.background,
                          //     Colors.green.shade800,
                          //   ],
                          // ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomCircleAvatar(
                              size: 75,
                            ),
                            Container(
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    "${state.currentUser?.name}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "See your profile",
                                    style: TextStyle(
                                      color: Colors.grey.shade200,
                                      fontSize: 14,
                                    ),
                                  ),
                                  trailing: Icon(Icons.arrow_right, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        key: UniqueKey(),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: ListTile(
                          tileColor: Colors.white,
                          contentPadding: const EdgeInsets.all(0.0),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.lock, color: Colors.black),
                            onPressed: () {
                              Navigator.pop(context);
                              _displayLogOutDialog(context);
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_right, color: Colors.black),
                            onPressed: () {
                              Navigator.pop(context);
                              _displayLogOutDialog(context);
                            },
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            _displayLogOutDialog(context);
                          },
                        ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border(
                      //       bottom: BorderSide(color: Colors.grey),
                      //     ),
                      //   ),
                      //   child: ListTile(
                      //     tileColor: Colors.white,
                      //     contentPadding: const EdgeInsets.all(0.0),
                      //     title: Text(
                      //       'Delete Account',
                      //       style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: 16,
                      //       ),
                      //     ),
                      //     leading: IconButton(
                      //       icon: Icon(Icons.clear, color: Colors.black),
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //         _displayDeleteAccountWarning(context);
                      //       },
                      //     ),
                      //     trailing: IconButton(
                      //       icon: Icon(Icons.arrow_right, color: Colors.black),
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //         _displayDeleteAccountWarning(context);
                      //       },
                      //     ),
                      //     onTap: () {
                      //       Navigator.pop(context);
                      //       _displayDeleteAccountWarning(context);
                      //     },
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  // Displays logout warning message
  void _displayLogOutDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            // title: Text(
            //   'You are',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            content: Text(
              'Are you sure you want to logout?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'CANCEL',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('LOGOUT', style: TextStyle(fontWeight: FontWeight.w600)),
                onPressed: () {
                  Navigator.pop(context);
                  BlocProvider.of<AuthCubit>(context).signOut();
                },
              )
            ],
          );
        });
  }

  //Displays warning message for deleting account
  void _displayDeleteAccountWarning(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.yellow[600],
            title: Text(
              'WARNING',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Are you sure you want to delete this account?',
              style: TextStyle(fontSize: 16),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('DELETE ACCOUNT'),
                onPressed: () {
                  Navigator.pop(context);
                  // deleteAccount();
                },
              )
            ],
          );
        });
  }
}

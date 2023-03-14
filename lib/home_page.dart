// import 'dart:html';

// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/loading.dart';
import 'package:sheveegan/features/auth/presentation/pages/login_page.dart';
import 'package:sheveegan/features/restaurants/presentation/geolocation_bloc/geolocation_bloc.dart';

import 'core/constants/strings.dart';
import 'core/error.dart';
import 'features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'features/scan_product/presentation/pages/scan_product_home_page.dart';
import 'features/restaurants/presentation/pages/restaurants_home_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "/";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  List _pages = [
    ScanProductHomePage(),
    RestaurantsHomePage(),
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 1) {
        BlocProvider.of<GeolocationBloc>(context).add(LoadGeolocationEvent());
        // BlocProvider.of<RestaurantsBloc>(context).add(GetRestaurantsEvent());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignedOutState) {
          Navigator.pushReplacementNamed(context, LoginPage.id);
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return LoadingPage();
          }
          if (state is AuthErrorState) {
            return ErrorPage(error: state.error);
          }
          if (state is LoggedInState) {
            return Scaffold(
              key: scaffoldKey,
              backgroundColor: Theme.of(buildContext).colorScheme.background,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Theme.of(buildContext).colorScheme.background,
                leadingWidth: 80,
                toolbarHeight: 80,
                leading: IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () => scaffoldKey.currentState!.openDrawer(),
                ),
                centerTitle: true,
                title: _currentIndex == 0
                    ? null
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          Strings.appTitle,
                          style: TextStyle(
                            // color: Theme.of(context).backgroundColor,
                            color: Colors.white,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'cursive',
                          ),
                        ),
                      ),
              ),
              drawer: Drawer(
                backgroundColor: Colors.white,
                child: ListView(
                  children: [
                    DrawerHeader(
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        backgroundImage: null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.person, size: 50, color: Colors.white),
                            // Text(
                            //   '${widget.user.email.substring(
                            //     0,
                            //     widget.user.email.indexOf('@'),
                            //   )}',
                            //   style: TextStyle(color: Colors.white, fontSize: 20),
                            // )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Theme.of(context).colorScheme.background,
//                Colors.deepOrange,
                            Colors.green.shade800,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      key: UniqueKey(),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0.0),
                        title: Text(
                          'Logout',
                          style: TextStyle(
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0.0),
                        title: Text(
                          'Delete Account',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        leading: IconButton(
                          icon: Icon(Icons.clear, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                            _displayDeleteAccountWarning(context);
                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_right, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                            _displayDeleteAccountWarning(context);
                          },
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _displayDeleteAccountWarning(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              body: _pages[_currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                elevation: 1,
                backgroundColor: Theme.of(context).colorScheme.background,
                // fixedColor: Colors.purple,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade500,
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                iconSize: 35,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),

                onTap: _updateIndex,
                items: [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: "Restaurants",
                    icon: Icon(Icons.dinner_dining),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  // Displays logout warning message
  void _displayLogOutDialog(BuildContext context) async {
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
              'Are you sure you want to logout?',
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
                child: Text('LOG OUT'),
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

import 'package:flutter/material.dart';
import 'package:sheveegan/assets/vegan_icon.dart';
import 'package:sheveegan/core/constants/colors.dart';
import 'package:sheveegan/login_page.dart';
import 'package:sheveegan/sign_up.dart';

class WelcomePage extends StatelessWidget {
  // const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientStartColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 150),
          decoration: BoxDecoration(color: gradientStartColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'She ',
                        style: TextStyle(
                          color: titleTextColorOne,
                          // color: Colors.green.shade600,
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cursive',
                        ),
                      ),
                      Icon(
                        VeganIcon.vegan_icon,
                        color: titleTextColorOne,
                        size: 30,
                      ),
                      Text(
                        'egan',
                        style: TextStyle(
                          color: titleTextColorOne,
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cursive',
                        ),
                      ),
                      // SizedBox(height: ,)
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    color: Colors.white,
                    onPressed: () {
                      Route route = MaterialPageRoute(builder: (context) => LoginPage());
                      Navigator.push(context, route);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      color: Colors.white,
                      onPressed: () {
                        Route route = MaterialPageRoute(builder: (context) => SignUpPage());
                        Navigator.push(context, route);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

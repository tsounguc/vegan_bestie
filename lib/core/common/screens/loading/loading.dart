import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(
              height: 10.h,
            ),
            Visibility(
              visible: false,
              child: Text(
                "Searching...",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

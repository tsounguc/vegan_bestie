import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({
    this.backgroundColor,
    super.key,
  });

  static const String id = '/loadingPage';
  final Color? backgroundColor;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const CircularProgressIndicator(),
            SizedBox(
              height: 10.h,
            ),
            Visibility(
              visible: false,
              child: Text(
                'Searching...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

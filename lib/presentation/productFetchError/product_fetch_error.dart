import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductFetchErrorPage extends StatelessWidget {
  final dynamic error;
  const ProductFetchErrorPage( {Key? key, this.error,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            Flexible(child: Text('$error', style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
            ),),),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
            Flexible(child: Text('$error')),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

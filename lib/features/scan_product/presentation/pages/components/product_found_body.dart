import 'package:flutter/material.dart';
import 'product_found_body_components/product_found_body_info.dart';
import 'product_found_body_components/product_found_image.dart';

class ProductFoundBody extends StatelessWidget {
  const ProductFoundBody({
    Key? key,
    // this.size,
  }) : super(key: key);
  // final Size? size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: ProductFoundBodyInfo(
              // size: size,
              ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.08,
          // bottom: MediaQuery.of(context).size.height * 0.92,
          left: 30,
          child: ProductFoundImage(),
        )
      ],
    );
  }
}

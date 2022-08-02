import 'package:flutter/material.dart';
import 'package:sheveegan/presentation/ProductFound/widgets/product_found_body_info.dart';
import 'package:sheveegan/presentation/ProductFound/widgets/product_found_image.dart';

class ProductFoundBody extends StatelessWidget {
  const ProductFoundBody({
    Key? key,
    // this.size,
  }) : super(key: key);
  // final Size? size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ProductFoundBodyInfo(
                // size: size,
              ),
              ProductFoundImage()
            ],
          ),
        ],
      ),
    );
  }
}

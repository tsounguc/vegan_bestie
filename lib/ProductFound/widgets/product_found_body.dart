import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheveegan/ProductFound/widgets/product_found_body_info.dart';
import 'package:sheveegan/ProductFound/widgets/product_found_image.dart';

class ProductFoundBody extends HookWidget {
  const ProductFoundBody({Key? key, this.size}) : super(key: key);
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size!.height,
            child: Stack(
              // overflow: ,
              children: [
                ProductFoundBodyInfo(size: size,),
                ProductFoundImage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

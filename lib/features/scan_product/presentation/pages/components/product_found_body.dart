import 'package:flutter/material.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/product_widget_body_components/product_image_component.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/product_widget_body_components/product_info_component.dart';

class ProductFoundBody extends StatelessWidget {
  const ProductFoundBody({
    super.key,
  });

  // final Size? size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          bottom: 0,
          child: ProductInfoComponent(),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.08,
          // bottom: MediaQuery.of(context).size.height * 0.92,
          left: 30,
          child: const ProductImageComponent(),
        ),
      ],
    );
  }
}

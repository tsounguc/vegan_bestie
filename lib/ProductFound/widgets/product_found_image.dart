import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/productprovider.dart';

class ProductFoundImage extends HookWidget {
  const ProductFoundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productScanResults = useProvider(productProvider.state);

    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              productScanResults.imageUrl == null ||
                      productScanResults.imageUrl!.isEmpty
                  ? Container(
                      height: 250,
                      width: 225,
                      decoration: BoxDecoration(
                          color: context.read(productProvider).sheVegan
                              ? gradientStartColor
                              : Colors.red.shade600,
                          borderRadius: BorderRadius.all(
                            Radius.circular(35),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38.withOpacity(0.25),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(5, 7),
                            )
                          ]),
                      child: Icon(
                        Icons.image_outlined,
                        color: context.read(productProvider).sheVegan
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                        size: 225,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(35),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38.withOpacity(0.25),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(5, 7),
                            )
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: context.read(productProvider).cachedNetworkImage,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

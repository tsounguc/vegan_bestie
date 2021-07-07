import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/productprovider.dart';

class AddProductFormImage extends HookWidget {
  const AddProductFormImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productScanResults = useProvider(productProvider.state);

    return productScanResults.imageToUpLoadPath!.isEmpty
        ? Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
                color: gradientStartColor,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 200,
                  icon: Icon(
                    Icons.add_photo_alternate,
                    color: Colors.green.shade50,
                    // size: 50,
                  ),
                  onPressed: () {
                    print("image picker to add picture");
                    context.read(productProvider).showPicker(context);
                  },
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: () {
              context.read(productProvider).showPicker(context);
            },
            child: Container(
              height: 250,
              width: 250,
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
                child: Image.file(
                  File(productScanResults.imageToUpLoadPath!),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
  }
}

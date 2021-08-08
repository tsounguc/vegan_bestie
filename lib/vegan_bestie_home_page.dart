import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/assets/vegan_icon.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/loading_state_page.dart';
import 'package:sheveegan/product_provider.dart';

import 'assets/barcode_icon.dart';

class VeganBestieHomePage extends HookWidget {
  // final productScanResults = useProvider(productProvider.state);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: gradientStartColor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    VeganIcon.vegan_icon,
                    color: titleTextColorOne,
                    size: 57,
                  ),
                  Text(
                    'egan',
                    style: TextStyle(
                      color: titleTextColorOne,
                      fontSize: 57,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cursive',
                    ),
                  ),
                  Text(
                    ' Bestie',
                    style: TextStyle(
                      color: titleTextColorOne,
                      // color: Colors.green.shade600,
                      fontSize: 57,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cursive',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 125.0,
                height: 125.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(70)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38.withOpacity(0.05),
                        spreadRadius: 2,
                        offset: Offset(3, 5)),
                  ],
                ),
                child: new RawMaterialButton(
                  // fillColor: Colors.green.shade600,
                  fillColor: Colors.white,
                  shape: new CircleBorder(),
                  elevation: 0.0,
                  child: Icon(
                    BarcodeIcon.barcode_icon,
                    color: Colors.green.shade600,
                    size: 50,
                  ),
                  onPressed: () {
                    context
                        .read(productProvider)
                        .onBarcodeButtonPressed(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

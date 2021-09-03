import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/ProductFound/widgets/product_found_body.dart';
import 'package:sheveegan/addProduct/add_product.dart';
import 'package:sheveegan/assets/barcode_icon.dart';
import 'package:sheveegan/assets/vegan_icon.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/product_provider.dart';
import 'package:sheveegan/size_config.dart';

class ProductFoundPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final productScanResults = useProvider(productProvider.state);
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Container(
      decoration: productScanResults.imageUrl != null &&
              productScanResults.imageUrl!.isNotEmpty
          ? BoxDecoration(
              color: context.read(productProvider).sheVegan
                  ? gradientStartColor
                  : Colors.red.shade600,
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.saturation),
                image: context.read(productProvider).imageProvider!,
              ),
            )
          : BoxDecoration(
              color: context.read(productProvider).sheVegan
                  ? gradientStartColor
                  : Colors.red.shade600,
            ),
      child: BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Vegan Bestie',
                  style: TextStyle(
                    color: titleTextColorOne,
                    fontSize: 37,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'cursive',
                  ),
                ),
              ],
            ),
            actions: [
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  // size: 25,
                  color: titleTextColorOne,
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Edit Product',
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("Edit Product"),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  )
                ],
                onSelected: (selectedValue) {
                  if (selectedValue == 'Edit Product') {
                    Route route = MaterialPageRoute(
                        builder: (context) =>
                            AddProduct(title: "Edit Product"));
                    Navigator.push(context, route);
                  }
                },
              )
            ],
          ),
          backgroundColor: context.read(productProvider).imageUrl != null
              ? Colors.transparent
              : context.read(productProvider).sheVegan
                  ? gradientStartColor
                  : Colors.red.shade600,
          body: ProductFoundBody(
            size: size,
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: context.read(productProvider).sheVegan
                ? Colors.green.shade600
                : Colors.red.shade600,
            onPressed: () {
              context.read(productProvider).onBarcodeButtonPressed(context);
            },
            child: Icon(
              BarcodeIcon.barcode_icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
    ;
  }
}

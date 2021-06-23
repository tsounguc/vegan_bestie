import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/add_product.dart';
import 'package:sheveegan/assets/barcode_icon.dart';
import 'package:sheveegan/assets/vegan_icon.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/productprovider.dart';

class ProductFoundHomePage extends HookWidget {


  @override
  Widget build(BuildContext context) {
    final productScanResults = useProvider(productProvider.state);
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: productScanResults.imageUrl!.isNotEmpty
          ? BoxDecoration(
        color: context.read(productProvider).sheVegan
            ? gradientStartColor
            : Colors.red.shade600,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.saturation),
          image: NetworkImage(
            "${productScanResults.imageUrl}",
          ),
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
            toolbarHeight: size.height * 0.12,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'She ',
                  style: TextStyle(
                    color: titleTextColorOne,
                    // color: Colors.green.shade600,
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cursive',
                  ),
                ),
                Icon(
                  VeganIcon.vegan_icon,
                  color: titleTextColorOne,
                  size: 30,
                ),
                Text(
                  'egan',
                  style: TextStyle(
                    color: titleTextColorOne,
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cursive',
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: context.read(productProvider).imageUrl != null
              ? Colors.transparent
              : context.read(productProvider).sheVegan
              ? gradientStartColor
              : Colors.red.shade600,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.3),
                        padding: EdgeInsets.only(
                          top: size.height * 0.09,
                          left: size.width * 0.09,
                          right: size.width * 0.09,
                        ),
                        height: size.height * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${productScanResults.productName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(width: 20,),
                                if (productScanResults.barcode != null && productScanResults.barcode!.isNotEmpty && context.read(productProvider).sheVegan)
                                  Tooltip(
                                    message: 'She Vegan! 😊',
                                    decoration:
                                    BoxDecoration(color: Colors.green),
                                    height: 50,
                                    child: Icon(
                                      VeganIcon.vegan_icon,
                                      color: gradientStartColor,
                                      size: 40,
                                    ),
                                  ),
                                if (productScanResults.barcode != null && productScanResults.barcode!.isNotEmpty && !context.read(productProvider).sheVegan)
                                  Tooltip(
                                    decoration:
                                    BoxDecoration(color: Colors.red),
                                    height: 50,
                                    message:
                                    "She ain\'t Vegan 😞 \ncontains ${context.read(productProvider).nonVeganIngredientsInProduct}",
                                    child: Icon(
                                      Icons.not_interested_outlined,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                    showDuration: Duration(seconds: 10),
                                    // waitDuration: Duration(seconds: 30),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Barcode: ${productScanResults.barcode}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    // color: Colors.green.shade900,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Ingredients: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          '${productScanResults.ingredients}',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'Labels: ${productScanResults.labels}',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
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
                                      color: context
                                          .read(productProvider)
                                          .sheVegan
                                          ? gradientStartColor
                                          : Colors.red.shade600,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black38
                                              .withOpacity(0.25),
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: Offset(5, 7),
                                        )
                                      ]),
                                  child: Icon(
                                    Icons.image_outlined,
                                    color: context
                                        .read(productProvider)
                                        .sheVegan
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
                                          color: Colors.black38
                                              .withOpacity(0.25),
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: Offset(5, 7),
                                        )
                                      ]),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(35),
                                    child: Image(
                                      fit: BoxFit.fill,
                                      height: 250,
                                      width: 225,
                                      image: NetworkImage(
                                        "${productScanResults.imageUrl}",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: UniqueKey(),
                backgroundColor: context.read(productProvider).sheVegan
                    ? Colors.green.shade600
                    : Colors.red.shade600,
                onPressed: () {
                  Route route =
                  MaterialPageRoute(builder: (context) => AddProduct());
                  Navigator.push(context, route);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 20,
              ),
              FloatingActionButton(
                heroTag: UniqueKey(),
                backgroundColor: context.read(productProvider).sheVegan
                    ? Colors.green.shade600
                    : Colors.red.shade600,
                onPressed: () {
                  context.read(productProvider).scan(context);
                },
                child: Icon(
                  BarcodeIcon.barcode_icon,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/assets/barcode_icon.dart';
import 'package:sheveegan/assets/vegan_icon.dart';
import 'package:sheveegan/productprovider.dart';

class SheVeganHomePage extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productScanResults = useProvider(productProvider.state);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: context.read(productProvider).sheVegan
            ? Colors.green.shade400
            : Colors.red.shade400,
        shadowColor: context.read(productProvider).sheVegan
            ? Colors.green.shade400
            : Colors.red.shade400,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('She ',
                style: TextStyle(
                  // color: Colors.green.shade900
                  color: Colors.white,
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'cursive',
                )
                // style: Theme.of(context).textTheme.headline1,
                ),
            Icon(
              VeganIcon.vegan_icon,
              // color: Colors.green.shade900,
              color: Colors.white,
              size: 30,
            ),
            Text(
              'egan',
              style: TextStyle(
                // color: Colors.green.shade900,
                color: Colors.white,
                fontSize: 37,
                fontWeight: FontWeight.bold,
                fontFamily: 'cursive',
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: context.read(productProvider).sheVegan
              ? Colors.green.shade50
              : Colors.red.shade50,
          // border: Border.all(color: Colors.transparent),
          // borderRadius: BorderRadius.only(
          //     topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  productScanResults.imageUrl == null ||
                          productScanResults.imageUrl!.isEmpty
                      ? Container(
                          height: size.height * .4,
                          width: size.width * .9,
                          decoration: BoxDecoration(
                            color: context.read(productProvider).sheVegan
                                ? Colors.green.shade400
                                : Colors.red.shade400,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.green.shade50,
                            size: 200,
                          ),
                        )
                      : Container(
                          height: size.height * .4,
                          width: size.width * .9,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${productScanResults.imageUrl}"),
                                fit: BoxFit.fill),
                            color: context.read(productProvider).sheVegan
                                ? Colors.green.shade400
                                : Colors.red.shade400,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ),
                  Container(
                    height: size.height * .4,
                    width: size.width * .9,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.(color: Colors.grey),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),

                    // margin: ,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Barcode: ${productScanResults.barcode}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green.shade900,
                                ),
                              ),
                              if (!context.read(productProvider).sheVegan)
                                Tooltip(
                                  decoration: BoxDecoration(color: Colors.red),
                                  height: 50,
                                  message:
                                      "contains ${context.read(productProvider).nonVeganIngredientsInProduct}",
                                  child: Icon(Icons.info_outline),
                                  showDuration: Duration(seconds: 5),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Product: ${productScanResults.productName}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green.shade900,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Ingredients: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green.shade900,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${productScanResults.ingredients}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green.shade900,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Labels: ${productScanResults.labels}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.green.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.read(productProvider).sheVegan
            ? Colors.green.shade400
            : Colors.red.shade400,
        onPressed: () {
          context.read(productProvider).scan(context);
        },
        child: Icon(
          BarcodeIcon.barcode_icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

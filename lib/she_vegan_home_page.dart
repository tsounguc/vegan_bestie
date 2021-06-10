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
    final productScanResults = useProvider(productProvider.state);
    // if (productScanResults.error!.isNotEmpty) {
    //   final snackBar = SnackBar(
    //     content: Text(productScanResults.error!),
    //     backgroundColor: Colors.green.shade400,
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            color: Colors.green.shade900,
          ),
          AnimatedContainer(
            color: Colors.white,
            duration: Duration(milliseconds: 250),
            // margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 75),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('She ',
                              style: TextStyle(
                                color: Colors.green.shade900,
                                fontSize: 37,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cursive',
                              )
                              // style: Theme.of(context).textTheme.headline1,
                              ),
                          Icon(
                            VeganIcon.vegan_icon,
                            color: Colors.green.shade900,
                            size: 30,
                          ),
                          Text(
                            'egan',
                            style: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 37,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'cursive',
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.account_circle,
                        color: Colors.green.shade500,
                        size: 42,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: context.read(productProvider).sheVegan
                        ? Colors.green.shade400
                        : Colors.red.shade400,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      productScanResults.imageUrl == null ||
                              productScanResults.imageUrl!.isEmpty
                          ? Icon(
                              Icons.image_outlined,
                              color: Colors.green.shade50,
                              size: 200,
                            )
                          : Expanded(
                              child: Image(
                                image: NetworkImage(
                                  "${productScanResults.imageUrl}",
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.read(productProvider).sheVegan
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            height: 20,
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
                )
              ],
            ),
          ),
        ],
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

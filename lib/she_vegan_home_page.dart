import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheveegan/assets/barcode_icon.dart';
import 'package:sheveegan/assets/vegan_icon.dart';

class SheVeganHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.green.shade900,),
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
                    color: Colors.green.shade400,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        color: Colors.green.shade50,
                        size: 200,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: Column(

                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20,),
                          Text(
                            'Barcode: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green.shade900,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Expanded(
                            child: Text(
                              'Product: ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green.shade900,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Ingredients: ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green.shade900,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Labels: ',
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
        backgroundColor: Colors.green.shade400,
        onPressed: () {},
        child: Icon(
          BarcodeIcon.barcode_icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/product_provider.dart';
import 'package:sheveegan/she_vegan_home_page.dart';
import 'package:sheveegan/size_config.dart';

import 'assets/vegan_icon.dart';

class VeganBestieHome extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(color: Colors.green.shade800),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal! * 3,
                    top: SizeConfig.blockSizeVertical! * 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        size: SizeConfig.blockSizeHorizontal! * 5,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 21),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Vegan Bestie',
                      style: TextStyle(
                        color: titleTextColorOne,
                        fontSize: SizeConfig.blockSizeHorizontal! * 6,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'cursive',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical! * 27,
                    bottom: SizeConfig.blockSizeVertical! * 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Tap to Scan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal! * 3,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read(productProvider)
                            .onBarcodeButtonPressed(context);
                        Route route = MaterialPageRoute(
                            builder: (context) => SheVeganHomePage());
                        Navigator.push(context, route);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(20),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                        alignment: AlignmentDirectional(-1, -0.75),
                        minimumSize: MaterialStateProperty.all(
                          Size.fromRadius(SizeConfig.blockSizeHorizontal! * 13),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          CircleBorder(),
                        ),
                      ),
                      child: ImageIcon(
                        AssetImage(
                            'assets/logo/VeganBestie_NoBackground_Fixed2.png'),
                        size: SizeConfig.blockSizeHorizontal! * 20.5,
                        color: Colors.blueGrey.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

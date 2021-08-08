import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/error_state_page.dart';
import 'package:sheveegan/ProductFound/product_found.dart';
import 'package:sheveegan/loading_state_page.dart';
import 'package:sheveegan/product_provider.dart';
import 'package:sheveegan/vegan_bestie_home_page.dart';

class SheVeganHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // final productScanResults = useProvider(productProvider.state);
    // if (productScanResults.loading) {
    //   return LoadingStatePage();
    // }
    // if (productScanResults.error!.isNotEmpty) {
    //   return ErrorStatePage();
    // }
    // if (productScanResults.error!.isEmpty &&
    //     productScanResults.productName!.isNotEmpty) {
    //   return ProductFoundPage();
    // }

    return VeganBestieHomePage();
  }
}

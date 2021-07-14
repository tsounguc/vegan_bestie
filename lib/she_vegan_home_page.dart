import 'dart:ui';

import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/addProduct/add_product.dart';
import 'package:sheveegan/error_state_page.dart';
import 'package:sheveegan/ProductFound/product_found.dart';
import 'package:sheveegan/loading_state_page.dart';
import 'package:sheveegan/product_provider.dart';

class SheVeganHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final productScanResults = useProvider(productProvider.state);
    if (productScanResults.loading) {
      return LoadingStatePage();
    }
    if (productScanResults.error!.isNotEmpty) {
      return ErrorStatePage();
    }

    return ProductFoundPage();
  }
}

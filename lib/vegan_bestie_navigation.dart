// import 'dart:presentation';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sheveegan/error_state_page.dart';
// import 'package:sheveegan/loading_state_page.dart';
// import 'package:sheveegan/product_provider.dart';
// import 'package:sheveegan/presentation/ProductFound/product_found.dart';
//
// class VeganBestieNavigation extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final productScanResults = useProvider(productProvider.state);
//     if (productScanResults.loading) {
//       return LoadingStatePage();
//     }
//     if (productScanResults.error!.isNotEmpty) {
//       return ErrorStatePage();
//     }
//
//     return ProductFoundPage();
//   }
// }

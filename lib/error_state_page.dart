// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sheveegan/presentation/addProduct/add_product.dart';
// import 'package:sheveegan/assets/barcode_icon.dart';
// import 'package:sheveegan/product_provider.dart';
//
// class ErrorStatePage extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final productScanResults = useProvider(productProvider.state);
//
//     return Container(
//       color: Colors.grey.shade200,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 100,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Center(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
//                 child: Text(
//                   "${productScanResults.error!.substring(0, 1).toUpperCase() + productScanResults.error!.substring(1)}",
//                   style: TextStyle(
//                       // color: Colors.white,
//                       // fontSize: 18,
//                       ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Column(
//               children: [
//                 Text(
//                   "Please try again",
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 Text("or"),
//                 Text(
//                   "Tap + to add product to database",
//                   style: TextStyle(fontSize: 16),
//                 )
//               ],
//             )
//           ],
//         ),
//         floatingActionButton: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             FloatingActionButton(
//               heroTag: UniqueKey(),
//               backgroundColor: Colors.grey.shade600,
//               onPressed: () {
//                 Route route =
//                     // MaterialPageRoute(builder: (context) => AddProduct());
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             AddProduct(title: "Add New Product"));
//                 Navigator.push(context, route);
//               },
//               child: Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//             ),
//             Container(
//               height: 20,
//             ),
//             FloatingActionButton(
//               heroTag: UniqueKey(),
//               backgroundColor: Colors.grey.shade600,
//               onPressed: () {
//                 context.read(productProvider).onBarcodeButtonPressed(context);
//               },
//               child: Icon(
//                 BarcodeIcon.barcode_icon,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

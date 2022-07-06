// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sheveegan/assets/vegan_icon.dart';
// import 'package:sheveegan/colors.dart';
// import 'package:sheveegan/product_provider.dart';
//
// class ProductFoundBodyInfo extends HookWidget {
//   const ProductFoundBodyInfo({Key? key, this.size}) : super(key: key);
//   final Size? size;
//
//   @override
//   Widget build(BuildContext context) {
//     final productScanResults = useProvider(productProvider.state);
//     return Container(
//       margin: EdgeInsets.only(top: size!.height * 0.3),
//       padding: EdgeInsets.only(
//         top: size!.height * 0.09,
//         left: size!.width * 0.09,
//         right: size!.width * 0.09,
//       ),
//       height: size!.height * 0.7,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(35),
//           topRight: Radius.circular(35),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   '${productScanResults.productName}',
//                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//               ),
//               Container(
//                 width: 20,
//               ),
//               if (productScanResults.barcode != null &&
//                   productScanResults.barcode!.isNotEmpty &&
//                   context.read(productProvider).sheVegan)
//                 Tooltip(
//                   message: 'She Vegan! 😊',
//                   decoration: BoxDecoration(color: Colors.green),
//                   height: 50,
//                   child: Icon(
//                     VeganIcon.vegan_icon,
//                     color: gradientStartColor,
//                     size: 40,
//                   ),
//                 ),
//               if (productScanResults.barcode != null &&
//                   productScanResults.barcode!.isNotEmpty &&
//                   !context.read(productProvider).sheVegan)
//                 Tooltip(
//                   decoration: BoxDecoration(color: Colors.red),
//                   height: 50,
//                   message:
//                       "She ain\'t Vegan 😞 \ncontains ${context.read(productProvider).nonVeganIngredientsInProduct}",
//                   child: Icon(
//                     Icons.not_interested_outlined,
//                     size: 40,
//                     color: Colors.red,
//                   ),
//                   showDuration: Duration(seconds: 10),
//                 ),
//             ],
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Barcode: ${productScanResults.barcode}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   // color: Colors.green.shade900,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Text(
//                     "Ingredients: ",
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: Text(
//                         '${productScanResults.ingredients}',
//                         style: TextStyle(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Expanded(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Labels: ${productScanResults.labels}',
//                     style: TextStyle(
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

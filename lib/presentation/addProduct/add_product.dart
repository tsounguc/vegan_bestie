// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:sheveegan/colors.dart';
// import 'package:sheveegan/presentation/addProduct/widgets/add_product_form.dart';
//
// class AddProduct extends HookWidget {
//   AddProduct({this.title});
//   String? title;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: gradientStartColor,
//       child: GestureDetector(
//         onTap: (){
//           FocusScope.of(context).requestFocus(new FocusNode());
//         },
//         child: Scaffold(
//           resizeToAvoidBottomInset: true,
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             title: Text(title!, style: TextStyle(color: Colors.white),),
//             elevation: 0,
//             backgroundColor: gradientStartColor,
//             leading: CloseButton(
//               color: Colors.white,
//             ),
//           ),
//           body: AddProductForm()
//         ),
//       ),
//     );
//   }
// }

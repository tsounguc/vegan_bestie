import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/product_found_body.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class ProductFoundPage extends StatelessWidget {
  const ProductFoundPage({super.key});

  static const String id = '/productFoundPage';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanProductCubit, ScanProductState>(
      builder: (context, state) {
        if (state is FetchingProduct) {
          return const CircularProgressIndicator();
        } else if (state is ProductFound) {
          return Container(
            decoration: state.product.imageFrontUrl != null && state.product.imageFrontUrl.isNotEmpty
                ? BoxDecoration(
                    color: state.isVegan! ? Theme.of(context).colorScheme.background : Colors.red,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.saturation),
                      image: CachedNetworkImageProvider(state.product.imageFrontUrl!),
                    ),
                  )
                : BoxDecoration(
                    color: state.isVegan! ? Theme.of(context).colorScheme.background : Colors.red,
                  ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    Strings.appTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  // actions: [
                  //   PopupMenuButton(
                  //     icon: Icon(
                  //       Icons.more_vert,
                  //       // size: 25,
                  //       color: Colors.white,
                  //     ),
                  //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  //       PopupMenuItem<String>(
                  //         value: 'Edit Product',
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //               child: Text("Edit Product"),
                  //             ),
                  //             Icon(Icons.edit),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //     onSelected: (selectedValue) {
                  //       // if (selectedValue == 'Edit Product') {
                  //       //   Route route = MaterialPageRoute(
                  //       //       builder: (context) =>
                  //       //           AddProduct(title: "Edit Product"));
                  //       //   Navigator.push(context, route);
                  //       // }
                  //     },
                  //   )
                  // ],
                ),
                backgroundColor: Colors.transparent,
                body: const ProductFoundBody(),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading.dart';

class CustomImageWidget extends StatelessWidget {
  CustomImageWidget({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
  }) : super(key: key);
  final String? imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.43,
      width: width ?? MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        // gradient:
        //     RadialGradient(colors: [Color(0XFF2E7D32), Colors.green.shade500]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(4, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: CachedNetworkImage(
          progressIndicatorBuilder: (context, text, downloadProgress) =>
              LoadingPage(),
          fit: BoxFit.cover,
          imageUrl: imageUrl ?? "",
          errorWidget: (context, error, value) => Container(),
        ),
      ),
    );
  }
}

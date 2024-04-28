import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:sheveegan/core/common/screens/loading/loading.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    required this.imageUrl,
    super.key,
    this.height,
    this.width,
  });

  final String? imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    debugPrint('image Url: $imageUrl');
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.43,
      width: width ?? MediaQuery.of(context).size.width * 0.80,
      decoration: const BoxDecoration(
        color: Colors.grey,
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
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: imageUrl == null
            ? Icon(
                Icons.image_outlined,
                size: MediaQuery.of(context).size.width * 0.65,
                color: Colors.grey,
              )
            : CachedNetworkImage(
                progressIndicatorBuilder: (
                  context,
                  text,
                  downloadProgress,
                ) =>
                    const LoadingPage(),
                fit: BoxFit.cover,
                imageUrl: imageUrl!,
                errorWidget: (context, error, value) => Container(),
              ),
      ),
    );
  }
}

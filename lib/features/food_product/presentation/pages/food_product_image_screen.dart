import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

class FoodProductImageScreen extends StatelessWidget {
  const FoodProductImageScreen({required this.imageUrl, super.key});

  final String? imageUrl;

  static const String id = '/foodProductImageScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: const CustomBackButton(),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 150),
        child: Center(
          child: Hero(
            tag: imageUrl ?? 'productImageScreen',
            child: imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, percentage) {
                      return const LoadingPage(
                        backgroundColor: Colors.black,
                      );
                    },
                    errorWidget: (context, error, child) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 150),
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 400,
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 400,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

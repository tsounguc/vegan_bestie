import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/media_resources.dart';
import 'package:sheveegan/core/resources/strings.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: CustomBackButton(
          color: context.theme.iconTheme.color!,
        ),
        centerTitle: true,
        // title: SizedBox(
        //   width: context.width * 0.5,
        //   child: const VeganBestieLogoWidget(
        //     size: 25,
        //     fontSize: 35,
        //   ),
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(MediaResources.pageNotFound),
          ),
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: Text(Strings.pageNotFoundText),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls({
    required this.controller,
    this.mainAxisAlignment = MainAxisAlignment.end,
    super.key,
  });

  final MainAxisAlignment? mainAxisAlignment;
  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment!,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back_ios : Icons.arrow_back,
            color: context.theme.iconTheme.color,
          ),
          onPressed: () async {
            if (await controller.canGoBack()) {
              await controller.goBack();
            } else {
              if (context.mounted) {
                CoreUtils.showSnackBar(
                  context,
                  'No forward history item',
                );
                return;
              }
            }
          },
        ),
        IconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_forward_ios : Icons.arrow_forward,
            color: context.theme.iconTheme.color,
          ),
          onPressed: () async {
            if (await controller.canGoForward()) {
              await controller.goForward();
            } else {
              if (context.mounted) {
                CoreUtils.showSnackBar(
                  context,
                  'No forward history item',
                );
              }
              return;
            }
          },
        ),
        IconButton(
          icon: Icon(
            Icons.replay,
            color: context.theme.iconTheme.color,
          ),
          onPressed: controller.reload,
        ),
      ],
    );
  }
}

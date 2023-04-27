import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  NavigationControls({required this.controller, this.mainAxisAlignment = MainAxisAlignment.end});

  MainAxisAlignment? mainAxisAlignment;
  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done || controller == null) {
          return Row(
            mainAxisAlignment: mainAxisAlignment!,
            children: const <Widget>[
              Icon(Icons.arrow_back_ios, color: Colors.white),
              Icon(Icons.arrow_forward_ios, color: Colors.white),
              Icon(Icons.replay, color: Colors.white),
            ],
          );
        }

        return Row(
          mainAxisAlignment: mainAxisAlignment!,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No back history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onPressed: () async {
                if (await controller.canGoForward()) {
                  await controller.goForward();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No forward history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay, color: Colors.black),
              onPressed: () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}

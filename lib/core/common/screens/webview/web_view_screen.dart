import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/screens/webview/navigation_controls.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, this.url});

  final String? url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _webViewController;
  int loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            setState(() {
              loadingPercentage = 0;
            });
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
                Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
                ''');
          },
          onNavigationRequest: (NavigationRequest navigationRequest) {
            if (navigationRequest.url.contains('tel')) {
              launchUrl(
                Uri(
                  scheme: 'tel',
                  path: navigationRequest.url.substring(3),
                ),
              );
              debugPrint('blocking navigation to $navigationRequest}');
              return NavigationDecision.prevent;
            } else if (navigationRequest.url.contains('https://play.google.com/')) {
              if (Platform.isAndroid) {
                launchUrl(
                  Uri.parse(navigationRequest.url),
                  mode: LaunchMode.externalNonBrowserApplication,
                );
              } else {
                CoreUtils.showSnackBar(
                  context,
                  'Device does not support Google Play Store',
                );
              }
              debugPrint('blocking navigation to $navigationRequest}');
              return NavigationDecision.prevent;
            } else if (navigationRequest.url.contains('https://apps.apple.com/')) {
              if (Platform.isIOS) {
                launchUrl(
                  Uri.parse(navigationRequest.url),
                  mode: LaunchMode.externalNonBrowserApplication,
                );
              } else {
                CoreUtils.showSnackBar(
                  context,
                  'Device does not support App Store',
                );
              }
              debugPrint('blocking navigation to $navigationRequest}');
              return NavigationDecision.prevent;
            } else if (navigationRequest.url.contains('mailto')) {
              launchUrl(
                Uri.parse(navigationRequest.url),
                mode: LaunchMode.externalNonBrowserApplication,
              );
              debugPrint('blocking navigation to $navigationRequest}');
              return NavigationDecision.prevent;
            } else {
              debugPrint('allowing navigation to $navigationRequest');
              return NavigationDecision.navigate;
            }
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: openDialog,
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          CoreUtils.showSnackBar(
            context,
            message.message,
          );
        },
      )
      ..loadRequest(
        Uri.parse(widget.url!),
      );

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _webViewController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: AppBar(
        leadingWidth: 80,
        toolbarHeight: 80,
        backgroundColor: context.theme.colorScheme.background,
        leading: !Navigator.of(context).canPop()
            ? null
            : CustomBackButton(
                color: context.theme.iconTheme.color!,
              ),
        centerTitle: true,
        title: SizedBox(
          width: context.width * 0.5,
          child: const VeganBestieLogoWidget(
            size: 25,
            fontSize: 35,
          ),
        ),
      ),
      body: loadingPercentage < 100
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: loadingPercentage / 100,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      color: context.theme.iconTheme.color,
                      fontSize: 18.sp,
                    ),
                    child: Text('Loading $loadingPercentage'),
                  ),
                ],
              ),
            )
          : WebViewWidget(
              controller: _webViewController,
            ),
      bottomNavigationBar: NavigationControls(
        controller: _webViewController,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  Future<void> openDialog(HttpAuthRequest httpRequest) async {
    final usernameTextController = TextEditingController();
    final passwordTextController = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${httpRequest.host}: ${httpRequest.realm ?? '-'}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  autofocus: true,
                  controller: usernameTextController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: passwordTextController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // Explicitly cancel the request on iOS as the OS does not emit new
            // requests when a previous request is pending.
            TextButton(
              onPressed: () {
                httpRequest.onCancel();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                httpRequest.onProceed(
                  WebViewCredential(
                    user: usernameTextController.text,
                    password: passwordTextController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Authenticate'),
            ),
          ],
        );
      },
    );
  }
}

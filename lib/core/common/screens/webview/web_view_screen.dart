import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/screens/webview/navigation_controls.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/core/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, this.url});

  final String? url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController _webViewController;
  int loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        toolbarHeight: toolbarHeight,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: !Navigator.of(context).canPop()
            ? null
            : const CustomBackButton(
                color: Colors.black,
              ),
        centerTitle: true,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: const VeganBestieLogoWidget(size: 25, fontSize: 35),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: WebView(
              gestureNavigationEnabled: true,
              initialUrl: widget.url,
              navigationDelegate: (NavigationRequest navigationRequest) {
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
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (url) {
                setState(() {
                  loadingPercentage = 0;
                });
                // }
              },
              onProgress: (int progress) {
                setState(() {
                  loadingPercentage = progress;
                });
              },
              onPageFinished: (url) {
                debugPrint('onPageFinished $url');
                setState(() {
                  loadingPercentage = 100;
                });
              },
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                _controller.complete(webViewController);
              },
            ),
          ),
          if (loadingPercentage < 100)
            Scaffold(
              backgroundColor: Colors.white,
              body: Center(
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
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                      child: Text('Loading $loadingPercentage'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: NavigationControls(
        controller: _controller,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}

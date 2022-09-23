import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/strings.dart';
import 'navigation_controls.dart';

class WebViewScreen extends StatefulWidget {
  final String? url;
  const WebViewScreen({Key? key, this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  var loadingPercentage = 0;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        // toolbarHeight: 60.h,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            Strings.appTitle,
            style: TextStyle(
              // color: Theme.of(context).backgroundColor,
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
              fontFamily: 'cursive',
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [NavigationControls(controller: _controller)],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: WebView(
              gestureNavigationEnabled: true,
              zoomEnabled: true,
              initialUrl: widget.url!,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (url) {
                setState(() {
                  loadingPercentage = 0;
                });
              },
              onProgress: (int progress) {
                setState(() {
                  loadingPercentage = progress;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  loadingPercentage = 100;
                });
              },
              onWebViewCreated: (WebViewController webViewController) {
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
                        child: Text("Loading $loadingPercentage")),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

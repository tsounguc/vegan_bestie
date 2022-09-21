import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/strings.dart';

class WebViewScreen extends StatefulWidget {
  final String? url;
  const WebViewScreen({Key? key, this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // iconTheme: Theme.of(context).iconTheme,
      //   toolbarHeight: 65.h,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: Padding(
      //     padding: const EdgeInsets.only(bottom: 16.0),
      //     child: Text(
      //       Strings.appTitle,
      //       style: TextStyle(
      //         // color: Theme.of(context).backgroundColor,
      //         color: Colors.white,
      //         fontSize: 36.sp,
      //         fontWeight: FontWeight.w800,
      //         fontFamily: 'cursive',
      //       ),
      //     ),
      //   ),
      //   // elevation: 0,
      //   backgroundColor: Theme.of(context).backgroundColor,
      //   // backgroundColor: Colors.green.shade50,
      // ),
      body: SafeArea(
        child: WebView(
          initialUrl: widget.url!,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}

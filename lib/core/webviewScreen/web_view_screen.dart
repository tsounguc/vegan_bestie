import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/constants/strings.dart';
import 'navigation_controls.dart';

class WebViewScreen extends StatefulWidget {
  final String? url;
  const WebViewScreen({Key? key, this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController _webViewController;
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
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: Theme.of(context).iconTheme,
        automaticallyImplyLeading: true,
        leading: !Navigator.of(context).canPop()
            ? null
            : IconButton(
                color: Colors.white,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
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
        actions: [NavigationControls(controller: _controller)],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: WebView(
              gestureNavigationEnabled: true,
              zoomEnabled: true,
              initialUrl: widget.url!,
              // initialUrl: widget.url! + "&native=true",
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (url) {
                // _webViewController
                //     .runJavascript("document.getElementsByTagName('header')[0].style.display='none'");
                // _webViewController
                //     .runJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
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
                print("onPageFinished " + url);
                // _webViewController.runJavascript(
                //     "document.getElementById('consumer-header-container__09f24__ieW2P border--bottom__09f24___mg5X border-color--default__09f24__NPAKY background-color--white__09f24__ulvSM').style.display='none'");
                // _webViewController
                //     .runJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
                // _webViewController
                //     .runJavascriptReturningResult("javascript:(function() { " +
                //         "var head = document.getElementsByTagName('header')[0];" +
                //         "head.parentNode.removeChild(head);" +
                //         "var footer = document.getElementsByTagName('footer')[0];" +
                //         "footer.parentNode.removeChild(footer);" +
                //         "})()")
                //     .then((value) => debugPrint('Page finished loading Javascript'))
                //     .catchError((onError) => debugPrint('$onError'));
                setState(() {
                  loadingPercentage = 100;
                });
              },
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                _controller.complete(webViewController);
                // _webViewController
                //     .runJavascript("document.getElementsByTagName('header')[0].style.display='none'");
                // _webViewController
                //     .runJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
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

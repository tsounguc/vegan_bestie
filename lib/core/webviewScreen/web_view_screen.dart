import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/constants/strings.dart';
import '../constants/size_config.dart';
import '../custom_appbar_title_widget.dart';
import '../custom_back_button.dart';
import '../vegan_bestie_logo_widget.dart';
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
        leadingWidth: 80,
        toolbarHeight: toolbarHeight,
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: true,
        leading: !Navigator.of(context).canPop()
            ? null
            : CustomBackButton(
                color: Colors.black,
              ),
        centerTitle: true,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: VeganBestieLogoWidget(size: 25, fontSize: 35),
        ),
        // title: CustomAppbarTitleWidget(
        //     imageOneName: 'assets/bread.png',
        //     imageTwoName: 'assets/tomato.png'),
        // actions: [NavigationControls(controller: _controller)],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: WebView(
              gestureNavigationEnabled: true,
              zoomEnabled: true,
              initialUrl: widget.url!,
              navigationDelegate: (NavigationRequest navigationRequest) {
                if (navigationRequest.url.contains("tel")) {
                  launchUrl(
                    Uri(
                      scheme: 'tel',
                      path: navigationRequest.url.substring(3),
                    ),
                  );
                  print('blocking navigation to $navigationRequest}');
                  return NavigationDecision.prevent;
                } else if (navigationRequest.url.contains("https://play.google.com/")) {
                  if (Platform.isAndroid) {
                    launchUrl(
                      Uri.parse(navigationRequest.url),
                      mode: LaunchMode.externalNonBrowserApplication,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Device does not support Google Play Store')),
                    );
                  }
                  print('blocking navigation to $navigationRequest}');
                  return NavigationDecision.prevent;
                } else if (navigationRequest.url.contains("https://apps.apple.com/")) {
                  if (Platform.isIOS) {
                    launchUrl(
                      Uri.parse(navigationRequest.url),
                      mode: LaunchMode.externalNonBrowserApplication,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Device does not support App Store')),
                    );
                  }
                  print('blocking navigation to $navigationRequest}');
                  return NavigationDecision.prevent;
                } else if (navigationRequest.url.contains("mailto")) {
                  launchUrl(
                    Uri.parse(navigationRequest.url),
                    mode: LaunchMode.externalNonBrowserApplication,
                  );
                  print('blocking navigation to $navigationRequest}');
                  return NavigationDecision.prevent;
                }
                // else if (navigationRequest.url.contains("maps")) {
                //   if (Platform.isIOS) {
                //     launchUrl(
                //       Uri(
                //         scheme: 'maps',
                //         path: navigationRequest.url.substring(5),
                //       ),
                //     );
                //   } else {
                //     launchUrl(
                //       Uri.parse(navigationRequest.url),
                //       mode: LaunchMode.externalNonBrowserApplication,
                //     );
                //   }
                //   print('blocking navigation to $navigationRequest}');
                //   return NavigationDecision.prevent;
                // }
                else {
                  print('allowing navigation to $navigationRequest');
                  return NavigationDecision.navigate;
                }
              },
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (url) {
                // _webViewController
                //     .runJavascript("document.getElementsByTagName('header')[0].style.display='none'");
                // _webViewController
                //     .runJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
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
      bottomNavigationBar: NavigationControls(
        controller: _controller,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}

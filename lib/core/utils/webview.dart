import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {

  static const String id = 'paystack_link_page';

  /// String variable of the paystack authorization url
  final String authorizationUrl;

  const CustomWebView({
    super.key,
    required this.authorizationUrl,
  });

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

//   late final PlatformWebViewControllerCreationParams params;
// if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//  params = PlatformWebViewControllerCreationParams(
//     allowsInlineMediaPlayback: true,
//  );
// } else {
//  params = const PlatformWebViewControllerCreationParams();
// }

// final WebViewController controller =
//     WebViewController.fromPlatformCreationParams(params);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme,
      appBar: AppBar(
        // backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 16,
            color: Color(0xFF2F3930),
          ),
        ),
      ),
      body: WebViewWidget(
      controller: 
      WebViewController(
      
      )..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {

        if(request.url.contains('https://www.lawyerpp.com')){
            Navigator.pop(context, 'success'); //close webview
          }
          if(request.url.contains('https://standard.paystack.co/close')){
            Navigator.pop(context, 'success'); //close webview
          }
          return NavigationDecision.navigate;
      
      },
        )
      )
      ..setUserAgent('Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Mobile Safari/537.36')
      ..loadRequest(Uri.parse(widget.authorizationUrl.toString()))
    ),
    );
  }

}
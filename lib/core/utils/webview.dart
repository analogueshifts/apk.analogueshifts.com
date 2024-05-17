import 'dart:async';
import 'dart:convert';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {


  final String authorizationUrl;

  const CustomWebView({
    super.key,
    required this.authorizationUrl,
  });

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {

   late WebViewController _controller;

   void signout() async{

      final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  logger.d('jnknklermklerm');
     await googleSignIn.signOut();
   }

  @override
  void initState() {
    super.initState();
    signout();
    _initializeWebViewController();
  }


  void _initializeWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          // onHttpAuthRequest: (request) {},
          // onPageStarted: (String url) {
          //   // ...
          // },
          onPageFinished: (String url) {
              _handleJsonData();
          },
          onNavigationRequest: (NavigationRequest request) {
            logger.e(request.url);
            final Uri uri = Uri.parse(request.url);
            logger.wtf(uri.path);
            if (uri.path == '/api/auth/google/callback') {
              //  Navigator.pop(context);
              Uri.dataFromString(request.url, mimeType: 'text/html', encoding: utf8).toString();
              // _handleJsonData();
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setUserAgent('Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Mobile Safari/537.36')
      ..loadRequest(Uri.parse(widget.authorizationUrl.toString(), ));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }

  void _handleJsonData() {
     
  
    _controller
        .runJavaScriptReturningResult("document.documentElement.innerHTML")
        .then((value) async{
         
     final decodedData = Uri.decodeFull(value.toString());
        final parsedData = jsonDecode(decodedData);
        var data = parsedData;
        final startIndex = data.indexOf('{');
        final endIndex = data.lastIndexOf('}');
        final jsonString = data.substring(startIndex, endIndex + 1);
        final cv = jsonDecode(jsonString);
        final _db = getIt<DBService>();
        UserViewModel auth_read = context.read<UserViewModel>();
        String? token = cv['data']['token'];
          Map<String, dynamic>? userMap = cv['data']['user']; // E
      //  logger.d(token);
        
        if (token!= null && userMap != null) {
           User user = User.fromJson(userMap); 
          await _db.saveToken(token);
        auth_read.saveUser(user);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const HomeNavigation()),
             (Route<dynamic> route) => false);
        }
        
        // logger.d(cv);
        // Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //           builder: (BuildContext context) =>
        //               const HomeNavigation()),
        //      (Route<dynamic> route) => false);
    }).catchError((error) {
      logger.e(error);
    });
  }

}
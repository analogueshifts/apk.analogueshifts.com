import 'dart:convert';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {


  final String authorizationUrl;

  const CustomWebView({
    super.key,
    required this.authorizationUrl,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {

   late WebViewController _controller;


  @override
  void initState() {
    super.initState();
    // await DefaultCacheManager().emptyCache();
    _initializeWebViewController();
  }


  void _initializeWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
              _handleJsonData();
          },
          onNavigationRequest: (NavigationRequest request) {
            logger.e(request.url);
            final Uri uri = Uri.parse(request.url);
            // ignore: deprecated_member_use
            logger.wtf(uri.path);
            if (uri.path == '/api/auth/google/callback') {
              //  Navigator.pop(context);
              Uri.dataFromString(request.url, mimeType: 'text/html', encoding: utf8).toString();
              _handleJsonData();
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
        logger.d('data from sh$parsedData');
        var data = parsedData;
        logger.d(data);
        final startIndex = data.indexOf('{');
        logger.d(startIndex);
        final endIndex = data.lastIndexOf('}');
        final jsonString = data.substring(startIndex, endIndex + 1);
        // ignore: deprecated_member_use
        logger.wtf(jsonString);
        final cv = jsonDecode(jsonString);
        final _db = getIt<DBService>();
        logger.w(cv);
        UserViewModel authRead = context.read<UserViewModel>();
        String? token = cv['data']['token'];
        logger.d(token);
          Map<String, dynamic>? userMap = cv['data']['user']; // E
       logger.d(token);
      if (token != null) {
         await _db.saveToken(token);
      }
        
        if (token!= null && userMap != null) {
           User user = User.fromJson(userMap); 
          await _db.saveToken(token);
        authRead.saveUser(user);
          Navigator.pushAndRemoveUntil(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const HomeNavigation()),
             (Route<dynamic> route) => false);
        }
      
    }).catchError((error) {
      // ignore: deprecated_member_use
      logger.wtf(error);
    });
  }

}
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/create_account_view.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/login_view.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView(bool showSigin) {
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return CreateAccountView(toggleView: toggleView);
    } else {
      return LoginView(toggleView: toggleView);
    }
  }
}
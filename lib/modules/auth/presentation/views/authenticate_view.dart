import 'package:analogue_shifts_mobile/modules/auth/presentation/views/create_account_view.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/views/login_view.dart';
import 'package:flutter/material.dart';



class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

toggleView(bool showSigin) {
    setState(() => showSignIn = !showSignIn);
  } 
  @override
  Widget build(BuildContext context) {
       if (showSignIn) {
         return LoginView(toggleView: toggleView);
    } else {
         return  CreateAccountView(toggleView: toggleView);

    }
  }
}
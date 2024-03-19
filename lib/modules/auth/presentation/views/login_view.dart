
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  final Function? toggleView;
  const LoginView({super.key, this.toggleView});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

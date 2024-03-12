import 'package:flutter/material.dart';

abstract class DisposableProvider with ChangeNotifier {
  void disposeValues(
    // super.dispose();
  );

   void dispose() {
    // Clean up resources here
    super.dispose();
  }
}
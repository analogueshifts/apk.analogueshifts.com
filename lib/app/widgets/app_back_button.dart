import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Image.asset(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/icons/back-button-black.png" : "assets/icons/back-button-white.png",)
    );
  }
}
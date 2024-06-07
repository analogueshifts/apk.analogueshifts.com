import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      margin: const EdgeInsets.only(left: 10),
      padding: EdgeInsets.zero,
      child: SvgPicture.asset(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/back.svg" : "assets/images/back-black.svg", width: 50, height: 20,)
    );
  }
}
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:flutter/material.dart';


class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.primaryGrey2, width: 1)
      ),
      padding: EdgeInsets.zero,
      child: Center(
        child: Icon(
          Icons.arrow_back_ios_outlined,
          color: AppColors.background,
      )
      ),
    );
  }
}
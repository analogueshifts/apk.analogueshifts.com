import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:flutter/material.dart';


class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.zero,
      child: Center(
        child: Icon(
          Icons.arrow_back,
          color: AppColors.primaryColor,
      )
      ),
    );
  }
}
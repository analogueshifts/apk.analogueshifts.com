import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/core/constants/app_strings.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';

class AppWidgets{
  final Widget logoIcon = Image.asset(
     AppAsset.logo,
      // semanticsLabel: 'App logo'
  );
  final Widget appTextName  = TextSemiBold(
    AppStrings.appNAme,
    color: AppColors.white,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  final Widget logoSpinner = const LogoandSpinner(
    imageAssets: 'assets/images/logo.png',
    reverse: true,
    arcColor: AppColors.primaryColor,
    spinSpeed: Duration(milliseconds: 500),
  );
}
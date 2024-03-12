import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:flutter/material.dart';


final lightTheme = ThemeData(
  // scaffoldBackgroundColor: AppColors.,
  primaryColor: AppColors.white,
  applyElevationOverlayColor: false,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 1,
    // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    // statusBarBrightness: Brightness.light,),

    // backgroundColor: AppColors.white,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: AppColors.textPrimaryColor,
  ),
);
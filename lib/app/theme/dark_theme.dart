import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';

final darkTheme = ThemeData(
   colorScheme: const ColorScheme(
    brightness: Brightness.dark, 
    primary: AppColors.primaryColor, 
    onPrimary: AppColors.primaryColor, 
    secondary: AppColors.background, 
    onSecondary: AppColors.white,
    error: Color(0xffFF0000), 
    onError: Colors.redAccent, 
    background: AppColors.background, 
    onBackground: Color(0xff000000), 
    surface:  Color(0xff000000), 
    onSurface: Color(0xff000000), 
    ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.background,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.white,
    selectedLabelStyle: TextStyle(
      color: AppColors.white,
      fontFamily: 
      AppFonts.manRope
    ),
    unselectedLabelStyle: TextStyle(
      color: AppColors.white,
      fontFamily: 
      AppFonts.manRope
    )
  ),
  useMaterial3: true,
  textTheme: TextTheme(
  labelMedium: TextStyle(
    fontFamily: AppFonts.manRope,
    color: Color(0xff000000),
  ),
  titleSmall: TextStyle(
    fontFamily: AppFonts.manRope,
    color: Color(0xff000000).withOpacity(0.36),
  ),
  bodyLarge: TextStyle(
    fontFamily: AppFonts.manRope,
    color: AppColors.white,
  ),
  bodyMedium: TextStyle(
    fontFamily: AppFonts.manRope,
    color: AppColors.white,
  ),
   bodySmall: TextStyle(
    fontFamily: AppFonts.manRope,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
    fontSize: 11
  ),
  titleMedium: TextStyle(
    fontFamily: AppFonts.manRope,
    color: AppColors.white,
  ),
  titleLarge: TextStyle(
    fontFamily: AppFonts.manRope,
    color: AppColors.white,
  )
  ),
  // scaffoldBackgroundColor: AppColors.,
   primaryColor: AppColors.background,
  scaffoldBackgroundColor: AppColors.background,
  iconTheme: const IconThemeData(
    color: AppColors.white
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.background,
  ),
  // applyElevationOverlayColor: false,
  // textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: AppColors.white
    ),
    backgroundColor: AppColors.background,
    elevation: 0,
    scrolledUnderElevation: 0

  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: AppColors.textPrimaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
   
  ),
  switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(AppColors.primaryColor),
        trackColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.selected) ? Color(0xffEBEBEB).withOpacity(0.6) : null)),
);
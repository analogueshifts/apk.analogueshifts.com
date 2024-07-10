import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:flutter/material.dart';


final lightTheme = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  colorScheme: const ColorScheme(
    brightness: Brightness.light, 
    primary: AppColors.primaryColor, 
    onPrimary: AppColors.primaryColor, 
    secondary: AppColors.background, 
    onSecondary: AppColors.primaryGrey2,
    error: Color(0xffFF0000), 
    onError: Colors.redAccent, 
    background: AppColors.white, 
    onBackground: Color(0xffFFFFFF), 
    surface:  AppColors.white, 
    onSurface: AppColors.white
    ),
  useMaterial3: true,
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xffFFFFFF).withOpacity(1),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
     type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.white,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.background,
  ),
  // scaffoldBackgroundColor: AppColors.,
  primaryColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.white,
  textTheme: TextTheme(
  bodyLarge: const TextStyle(
    fontFamily: AppFonts.manRope,
    color: AppColors.background,
    fontWeight: FontWeight.w500,
    fontSize: 14
  ),
  bodyMedium: const TextStyle(
    fontFamily: AppFonts.manRope,
    color: AppColors.background,
  ),
  bodySmall: TextStyle(
    fontFamily: AppFonts.manRope,
    color: const Color(0xff000000).withOpacity(0.36),
    fontWeight: FontWeight.w400,
    fontSize: 11
  ),
  titleSmall: const TextStyle(
    fontFamily: AppFonts.manRope,
    color: AppColors.background,
    fontSize: 10
  ),
  titleMedium: TextStyle(
    fontFamily: AppFonts.manRope,
    color: const Color(0xff000000).withOpacity(0.36),
    fontSize: 15
  ),
  titleLarge: const TextStyle(
    fontFamily: AppFonts.manRope,
    color: AppColors.background,
    fontSize: 20,
    fontWeight: FontWeight.w900
  ),
  displayMedium: const TextStyle(
    fontFamily: AppFonts.manRope,
    color: AppColors.background,
    fontSize: 18,
    fontWeight: FontWeight.w900
  ),
  ),
  
  // applyElevationOverlayColor: false,
  // textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(
      color: AppColors.background
    ),
    

  ),
   iconTheme: const IconThemeData(
    color: AppColors.background
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.white
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: AppColors.textPrimaryColor,
  ),
  unselectedWidgetColor: const Color(0xffDEDEDE),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(const Color(0xffEBEBEB)),
        trackColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.selected) ? const Color(0xffEBEBEB).withOpacity(0.6) : null)),
);


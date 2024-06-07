import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  // fillColor: AppColors.inputFieldColor,
  filled: false,
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: AppColors.primaryGrey2, width: 1)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.background
      )),
  disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: AppColors.primaryGrey2, width: 1)),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        width: 2,
        color: Colors.red,
      )),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        width: 2,
        color: Colors.red,
      )),
  errorStyle: const TextStyle(
    // height: ,
    color: Colors.redAccent,
  ),
  labelStyle: const TextStyle(
    color: AppColors.labelTextColor,
  ),
  hintStyle: TextStyle(
    color: const Color(0xff000000).withOpacity(0.4),
    fontFamily: AppFonts.manRope,
    fontSize: 14.0,
  ),
);
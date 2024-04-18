import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppSnackbar {
  AppSnackbar._();

  static success(
      BuildContext context, {
        required String message,
      }) {
    showTopSnackBar(
        Overlay.of(context),
        Stack(
          children: [
            CustomSnackBar.success(
              backgroundColor: const Color.fromARGB(255, 45, 128, 91),
              messagePadding: EdgeInsets.zero,
              message: "",
              textAlign: TextAlign.left,
              textStyle: TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.manRope
              ),
              // textStyle: AppTextStyle.black(12, color: Colors.white),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Success!",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFonts.manRope
                        ),
                        // style: AppTextStyle.blackBold(18, color: Colors.white),
                      ),
                      const Gap(3),
                      Text(
                        message,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFonts.manRope
                        ),
                        // style: AppTextStyle.black(14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        dismissDirection: [DismissDirection.horizontal, DismissDirection.up]);
  }

  static warning(
      BuildContext context, {
        required String message,
      }) {
    showTopSnackBar(
        Overlay.of(context),
        Stack(
          children: [
            CustomSnackBar.success(
              backgroundColor: const Color(0xffFCA652),
              messagePadding: EdgeInsets.zero,
              message: "",
              textAlign: TextAlign.left,
              textStyle: TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.manRope
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Warning!",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFonts.manRope
                        ),
                        // style: AppTextStyle.blackBold(18, color: Colors.white),
                      ),
                      const Gap(3),
                      Expanded(
                        child: Text(
                          message,
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFonts.manRope
                          ),
                          // style: AppTextStyle.black(14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        dismissDirection: [DismissDirection.horizontal, DismissDirection.up]);
  }

  static error(
      BuildContext context, {
        required String message,
      }) {
    showTopSnackBar(
        Overlay.of(context),
        Stack(
          children: [
            CustomSnackBar.success(
              backgroundColor: const Color(0xffff5252),
              messagePadding: EdgeInsets.zero,
              message: "",
              textAlign: TextAlign.left,
              textStyle: TextStyle(
                  color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.manRope
              ),

              // textStyle: AppTextStyle.black(12, color: Colors.white),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Error!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppFonts.manRope
                        ),
                        // style: AppTextStyle.blackBold(18, color: Colors.white),
                      ),
                      const Gap(3),
                      Text(
                        message,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFonts.manRope
                        ),
                        // style: AppTextStyle.black(14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        dismissDirection: [DismissDirection.horizontal, DismissDirection.up]);
  }
}
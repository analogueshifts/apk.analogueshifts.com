import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:analogue_shifts_mobile/modules/uploads/presentation/changeNotifiers/upload_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';


class CompanySavedSuccess extends StatelessWidget {
  const CompanySavedSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(8)
              ),
              padding:
              const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset("assets/images/Frame 482367.png", width: double.infinity,),
                      const Gap(20),
                      const Text(
                        "Success! Your company details have been saved, and your job posting has been successfully posted. ",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          color: Color(0xff7B7B7B),
                          // fontFamily: AppFonts.mulishRegular,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          // color: AppColors.textColor,
                        ),
                      ),
                      const Gap(16),
                    ],
                  ),

                  const Gap(24),
                  Column(
                    children: [
                      TouchableOpacity(
                        onTap: () async {
                          context.read<FileUploadNotifier>().disposeValues();
                          //  Navigator.pop(context);
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);

                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor,
                          ),
                          child: SizedBox(
                            height: 15.h,
                            child: const Center(
                              child: Text(
                                "Go Back Home!",
                                style: TextStyle(
                                  // fontFamily: AppFonts.mulishRegular,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(16),


                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

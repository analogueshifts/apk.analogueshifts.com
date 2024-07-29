import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/change_notifier/event.notifier.dart';
import 'package:analogue_shifts_mobile/modules/uploads/presentation/changeNotifiers/upload_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';


class EventCreationSuccess extends StatelessWidget {
  const EventCreationSuccess({super.key});

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
                      Image.asset("assets/images/tick-good-green.png", width: double.infinity, height: 80.h,),
                      const Gap(20),
                      const Text(
                        "Your event has been successfully created!",
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

                  const Gap(20),
                  Column(
                    children: [
                      TouchableOpacity(
                        onTap: () async {
                          Provider.of<EventProvider>(listen: false, context).getSavedEvents(context);
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
                            height: 18.h,
                            child: const Center(
                              child: Text(
                                "Back to events",
                                style: TextStyle(
                                  // fontFamily: AppFonts.mulishRegular,
                                    fontSize: 13,
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

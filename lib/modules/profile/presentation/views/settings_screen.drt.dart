import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PaylonyAppBarTwo(title: "Settings",),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        children: [
          _navCard(const Image(image: AssetImage("assets/icons/lock_icon.png"), width: 45,height: 45,), "Change Password", () { 
            context.goNamed('change-password');
          }),
          _navCard(const Image(image: AssetImage("assets/icons/settings_icon.png"), width: 45,height: 45,), "Deactivate Account", () { 
            showDialog(context: context, builder:(context) {
              return dialog();
            },);
          }),
        ],
      ),
    );
  }

   Widget _navCard(Widget icon, String name, VoidCallback onTap){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TouchableOpacity(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                const Gap(5),
                TextSemiBold(name, fontSize: 16, fontWeight: FontWeight.w700,),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_outlined, size: 16, color: AppColors.grey,)

          ],
        ),
      ),
    );
  }

  Widget dialog() {
    return Dialog(
      backgroundColor: Color(0xffFFFFFF).withOpacity(1),
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
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                       SvgPicture.asset(AppAsset.logout),
                      const Gap(35),
                      const Text(
                        'Deactivate Account',
                        style: TextStyle(
                          // fontFamily: AppFonts.mulishRegular,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          // color: AppColors.black,
                        ),
                      ),
                      const Gap(18),
                      const Text(
                        'Your Profile would be temporarily hidden until you activate it again by logging back in.',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          color: Color(0xff6D6D6D),
                          // fontFamily: AppFonts.mulishRegular,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
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
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor,
                          ),
                          child: const Center(
                            child: Text(
                              "Proceed",
                              style: TextStyle(
                                  // fontFamily: AppFonts.mulishRegular,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                       const Gap(16),
                      TouchableOpacity(
                        onTap: () {
                          // Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryColor
                                // width: 1, color: AppColors.secondary,
                                ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "Yes, deactivate my account",
                              style: TextStyle(
                                fontFamily: AppFonts.manRope,
                                color: AppColors.primaryColor,
                                  // fontFamily: AppFonts.mulishRegular,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  // color: AppColors.secondary
                                  ),
                            ),
                          ),
                        ),
                      ),
                      
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

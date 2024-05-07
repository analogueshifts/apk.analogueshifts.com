import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DeactivateAccountScreen extends StatelessWidget {
  const DeactivateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, UserViewModel user, child) {
      return Scaffold(
        appBar: const PaylonyAppBarTwo(title: "Deactivate Account"),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              const Gap(15),
              user.authState.user?.profile == null  ? const Icon(Icons.verified_user) : CircleAvatar(
                  radius: 30.w,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user.authState.user?.profile ?? "",
                      width: 60.w,
                      height: 60.h,
                      placeholder: (context, url) => CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        minRadius: 50,
                        child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error, size: 50,),
                    ),
                  ),
                ),
              const Gap(5),
              Text(
                Functions.capitalize(user.authState.user?.name.toString() ?? ""),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Gap(25),
              Text(
                'Temporarily  Deactivate your account instead of completely deleting it',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800
                ),
              ),
              const Gap(15),
              Text(
                'Your Profile would be temporarily hidden until you activate it again by logging back in.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13
                ),
              ),
              const Gap(20),
              BusyButton(title: "Deactivate Account", onTap:() {
               showDialog( barrierColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.transparent .withOpacity(0.6) : Color(0xff110C00).withOpacity(0.8),context: context, builder:(context) {
                return deactivateDialog(context);
              },);
                
              },),
              const Gap(15),
              InkWell(
                onTap: () {
                  showDialog( barrierColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.transparent .withOpacity(0.6) : Color(0xff110C00).withOpacity(0.8),context: context, builder:(context) {
                return deleteDialog(context);
              },);
                },
                child: Container(
                  width: double.infinity,
                  child: Text("Delete Account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: const Color(0xff6D6D6D)
                  ),
                  ),
                ),
              )
            ],
          ),
          ),
      );
      }
    );
  }

  Widget deactivateDialog(BuildContext context) {
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



  Widget deleteDialog(BuildContext context) {
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
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                       Image.asset("assets/images/warninng.png", width: 50.w,),
                      const Gap(25),
                      const Text(
                        'Delete  your account?',
                        style: TextStyle(
                          // fontFamily: AppFonts.mulishRegular,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          // color: AppColors.black,
                        ),
                      ),
                      const Gap(18),
                      
                      const Text(
                        'You will lose all your data by deleting your account. This action cannot be undone ',
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
                            color: Color(0xffFF0000)
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
                              color: Color(0xffFF0000)
                                // width: 1, color: AppColors.secondary,
                                ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "Yes, deactivate my account",
                              style: TextStyle(
                                fontFamily: AppFonts.manRope,
                                color: Color(0xffFF0000),
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
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_back_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TouchableOpacity(
          onTap:(){
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeNavigation()),
                    (Route<dynamic> route) => true);
          },
          child: const AppBackButton(),
        ),
        title: TextBold(""),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: ListView(children: [
          const Gap(20),
          Row(
            children: [
              const Image(image: AssetImage("assets/images/Avatar Image.png"), width: 60, height: 60,),
              const Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold("Hi!, John", fontSize: 16,),
                  TextSemiBold("john@gmail.com", color: AppColors.grey,)
                ],
              )
            ],
          ),
          const Gap(30),
          _navCard(const Image(image: AssetImage("assets/images/avatar_image.png"), width: 45,height: 45,), "Edit Profile", () { }),
          _navCard(const Image(image: AssetImage("assets/images/work.png"), width: 45,height: 45,), "Jobs Applied", () { }),
          _navCard(const Image(image: AssetImage("assets/images/notification.png"), width: 45,height: 45,), "Notification", () { }),
          _navCard(const Image(image: AssetImage("assets/images/settings.png"), width: 45,height: 45,), "Settings", () {
            context.goNamed("settings");

          }),
          _navCard(const Image(image: AssetImage("assets/images/write.png"), width: 45,height: 45,), "FAQ", () { }),
          _navCard(const Image(image: AssetImage("assets/images/logout.png"), width: 45,height: 45,), "Logout", () {
            // context.read<UserViewModel>().logoutUser(context);
           showDialog(context: context, builder:(context) {
             return dialog();
           },);

          }),
          Center(child: context.read<UserViewModel>().authState.isGenerating == true ?  const CircularProgressIndicator(color: AppColors.primaryColor,) : Container())
        ],),
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
    bool _isProcessing = false;
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
                        'Log Out',
                        style: TextStyle(
                          // fontFamily: AppFonts.mulishRegular,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          // color: AppColors.black,
                        ),
                      ),
                      const Gap(18),
                      const Text(
                        'Oh no you’re leaving, are you sure?',
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
                          context.pop();
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
                                "No, Cancel",
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
                      Consumer<UserViewModel>(
                        builder: (context, UserViewModel user, child) {
                        return TouchableOpacity(
                          onTap: () async {
                            setState(() {
                                _isProcessing = true;
                              });
                            await user.logoutUser(context).then((value) {
                              if (value) {
                                context.replace(Routes.authenticate);
                              }
                              setState(() {
                                _isProcessing = false;
                              });
                            });
                            setState(() {
                                _isProcessing = false;
                              });
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
                            child: SizedBox(
                              height:15.h,
                              child: Center(
                                child: _isProcessing ?  SizedBox(
                                  height: 25.h,
                                  child: CircularProgressIndicator()) : Text(
                                  "Yes, log me out",
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
                        );
                        }
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

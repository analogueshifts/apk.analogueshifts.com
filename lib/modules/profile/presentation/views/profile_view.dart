import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_back_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.red,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: AppColors.white,),
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
           showAlertDialog(context);

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

  showAlertDialog(BuildContext context) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: AppColors.white,
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        height: screenHeight(context) * 0.35,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SvgPicture.asset(AppAsset.logout),
                const Gap(6),
                TextBold("Log Out", fontSize: 18,),
                const Gap(6),
                TextSemiBold("Oh no you’re leaving, are you sure?", color: const Color(0xff000000).withOpacity(0.6),),
              ],
            ),

            Column(
              children: [
                BusyButton(title: "No, cancel", onTap: () {
                  context.pop(context);
                }),
                const Gap(10),
                Consumer<UserViewModel>(
                  builder: (context, auth, child) {
                    return InkWell(
                      onTap: () async{
                        // context.pop(context);
                       auth.logoutUser(context);

                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(8)

                        ),
                        child:  Center(
                            child: auth.authState.isGenerating ? const CircularProgressIndicator() : TextSemiBold("Yes, log me out")),
                      ),
                    );
                  },
                )
              ],
            )

            
          ],
        ),
      )

    );

    // show the dialog
    showDialog(
      // barrierDismissible: context.watch<UserViewModel>().authState.isGenerating ?? true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

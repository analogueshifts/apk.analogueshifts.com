import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_back_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

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
        systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: AppColors.white,),
        leading: TouchableOpacity(
          onTap:(){
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeNavigation()),
                    (Route<dynamic> route) => true);
          },
          child: const AppBackButton(),
        ),
        title: TextBold(""),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Column(children: [
          Gap(20),
          Row(
            children: [
              Image(image: AssetImage("assets/images/Avatar Image.png"), width: 60, height: 60,),
              Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold("Hi!, John", fontSize: 16,),
                  TextSemiBold("john@gmail.com", color: AppColors.grey,)
                ],
              )
            ],
          ),
          Gap(30),
          _navCard(Image(image: AssetImage("assets/images/avatar_image.png"), width: 45,height: 45,), "Edit Profile", () { }),
          _navCard(Image(image: AssetImage("assets/images/work.png"), width: 45,height: 45,), "Jobs Applied", () { }),
          _navCard(Image(image: AssetImage("assets/images/notification.png"), width: 45,height: 45,), "Notification", () { }),
          _navCard(Image(image: AssetImage("assets/images/settings.png"), width: 45,height: 45,), "Settings", () { }),
          _navCard(Image(image: AssetImage("assets/images/write.png"), width: 45,height: 45,), "FAQ", () { }),
          _navCard(Image(image: AssetImage("assets/images/logout.png"), width: 45,height: 45,), "Logout", () { })
        ],),
      ),
    );
  }

  Widget _navCard(Widget icon, String name, VoidCallback onTap){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              Gap(5),
              TextSemiBold(name, fontSize: 16, fontWeight: FontWeight.w700,),
            ],
          ),
          TouchableOpacity(
            onTap: onTap,
              child: Icon(Icons.arrow_forward_ios_outlined, size: 16, color: AppColors.grey,))

        ],
      ),
    );
  }
}

import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PaylonyAppBarTwo(title: "Settings",),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        children: [
          _navCard(context, const Image(image: AssetImage("assets/icons/lock_icon.png"), width: 45,height: 45,), "Change Password", () { 
            Navigator.pushNamed(context, Routes.changePassword);
          }),
          _navCard(context, const Image(image: AssetImage("assets/icons/settings_icon.png"), width: 45,height: 45,), "Deactivate Account", () { 
            
            Navigator.pushNamed(context, Routes.deactivateAccount);
          }),
        ],
      ),
    );
  }

   Widget _navCard(BuildContext context,  icon, String name, VoidCallback onTap){
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
                 TextSemiBold(name, fontSize: 16, fontWeight: FontWeight.w700, style: Theme.of(context).textTheme.bodyMedium,),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_outlined, size: 16, color: AppColors.grey,)

          ],
        ),
      ),
    );
  }
}

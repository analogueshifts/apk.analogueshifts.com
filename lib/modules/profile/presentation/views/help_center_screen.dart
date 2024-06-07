import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/utils/url_launcher.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/faq_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final _url = getIt<UrlLauncher>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PaylonyAppBarTwo(title: "Help Center"),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        children: [
          _navCard(const Image(image: AssetImage("assets/icons/lock_icon.png"), width: 45,height: 45,), "FAQ", 'Find intelligent answers instantly', () { 
            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FaqScreen()
          ),
        );
          }, context),
          _navCard(const Image(image: AssetImage("assets/icons/settings_icon.png"), width: 45,height: 45,), "Email Us", 'Start a conversation now', () async{ 
            await  _url.makeEmailLaunch('support@analogueshifts.com');
          }, context),
        ],
      ),
    );
  }

   Widget _navCard(Widget icon, String name, String subText, VoidCallback onTap, BuildContext context){
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextSemiBold(name, fontSize: 16, fontWeight: FontWeight.w700, style: Theme.of(context).textTheme.bodyMedium,),
                TextSemiBold(subText, fontSize: 16, fontWeight: FontWeight.w700, style: Theme.of(context).textTheme.bodySmall,),
                  ],
                )
                
              ],
            ),
            const Icon(Icons.arrow_forward_ios_outlined, size: 16, color: AppColors.grey,)

          ],
        ),
      ),
    );
  }
}
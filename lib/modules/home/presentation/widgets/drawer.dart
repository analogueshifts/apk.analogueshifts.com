import 'package:analogue_shifts_mobile/app/notifier/app_notifier.dart';
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/widgets/custom_single_chile_scroll_view.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

@override
  void initState() {
    biometrics = getIt<DBService>().getTheme()!;
    Logger().d(biometrics);
    super.initState();
  }

  bool biometrics = false;
  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.1, color: Theme.of(context).unselectedWidgetColor.withOpacity(0.1)))
            ),
         
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TouchableOpacity(
                      onTap:() => Navigator.pop(context),
                      child: SvgPicture.asset("assets/icons/close_icon.svg"))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/Avatar Image.png", width: 40.w,),
                    const Gap(5),
                    Text("Hello, John", style: Theme.of(context).textTheme.titleLarge,),
                    const Gap(3),
                    Text("@JohnJames", style: Theme.of(context).textTheme.bodySmall,),
                    // Gap(10)
                  ],
                )
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset("assets/images/avatar_image.png", width: 40.w,),
            title: Text('My Profile', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600
            ),),
            onTap: () {
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset("assets/images/document.png", width: 40.w,),
            title: Text('Vetting System', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600
            ),),
            onTap: () {
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset("assets/images/card.png", width: 40.w,),
            title: Text('Payment Gateway', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600
            ),),
            onTap: () {
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset("assets/images/write.png", width: 40.w,),
            title: Text('Help Center', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600
            ),),
            onTap: () {
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset("assets/images/moon.png", width: 40.w,),
            title: Text('Dark Mode', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600
            ),),
            trailing: Transform.scale(
              scale: 0.5,
              child: Switch(
                value: biometrics,
                activeColor: AppColors
                .primaryColor,
                onChanged: (bool value) {
                  if(mounted == false)return;
                  setState(() {
                    biometrics = value;
                    Logger().d(value);
                    context.read<AppChangeNotifier>().toggleTheme(value);
                  });
                },
              ),
            ),
            onTap: () {
            },
          ),
          const Gap(10),
          const Spacer(),
          Container(
            height: 80.h,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/banner.png"), fit: BoxFit.fill)
            ),
          ),
          const Gap(10),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset("assets/images/star.png", width: 40.w,),
            title: Text('Rate Us', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600
            ),),
            onTap: () {
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset("assets/images/logout.png", width: 40.w,),
            title: Text('Log Out', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600
            ),),
            onTap: () {
            },
          ),
        ],
          ),
      ),
    );
  }
}
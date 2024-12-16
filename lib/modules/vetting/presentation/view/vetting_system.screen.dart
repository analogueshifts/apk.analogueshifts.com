import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/app/widgets/busy_button.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/text_field.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/widgets/shimmer-loading-list.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/notification_icon.dart';
import 'package:analogue_shifts_mobile/modules/vetting/presentation/change_notifiers/vetting.notifier.dart';
import 'package:analogue_shifts_mobile/modules/vetting/presentation/view/create_vetting_system.screen.dart';
import 'package:analogue_shifts_mobile/modules/vetting/presentation/widgets/no_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class VettingSystemScreen extends StatefulWidget {
  const VettingSystemScreen({super.key});

  @override
  State<VettingSystemScreen> createState() => _VettingSystemScreenState();
}

class _VettingSystemScreenState extends State<VettingSystemScreen> {

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_){
      if(mounted){
        context.read<VettingNotifier>().getAllForm(context);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: TouchableOpacity(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
              width: 20, height: 20,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: const Icon(Icons.menu)
          ),
        ),
        title: TextBold("Vetting System", fontSize: 20, color: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,),
        centerTitle: true,
        actions: [
          const NotificationIcon()
        ],
      ),
      body: Consumer<VettingNotifier>(
        builder: (_, forms, __) =>
         SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal:
          20, vertical: 20),
          child: Column(
            children: [
              const Gap(10),
              TextFormField(
                // controller: _search,
                decoration: textInputDecoration.copyWith(
                    fillColor: Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.white : AppColors.background,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xffD2D2D2) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.4) : const Color(0xffFFFFFF).withOpacity(0.18)
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xffD2D2D2) : const Color(0xffFFFFFF).withOpacity(0.3)
                    ),
                    hintText: "Search for forms",
                    prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color,)
                ),
              ),
              Gap(20),


              forms.forms.isEmpty && forms.isUploading == true  ?
              ShimmerLoadingList() :
              forms.forms.isEmpty ?
              _noVettingCard(context) :
              Column(
                children: [
                  // const Gap(10),
                  Column(
                      children:
                      forms.forms.map((e) =>
                          ListTile(
                            onTap: (){

                            },
                            contentPadding: EdgeInsets.zero,
                            leading:SvgPicture.asset("assets/images/form-default.svg", width: 40.w, height: 40.h,),
                            title: TextSemiBold(e?.title.toString() ?? ""),
                            subtitle: TextSemiBold("Short text questions", color: _isLight ? Color(0xff000000).withOpacity(0.36) : AppColors.grey,),
                            trailing: Icon(Icons.keyboard_arrow_right_outlined, size: 30, color: _isLight ? AppColors.background : AppColors.white, ),
                          )
                      ).toList()
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}



Widget _noVettingCard(BuildContext context){
  return Column(
    children: [
      const Gap(40),
      SvgPicture.asset("assets/images/no-vetting.svg"),
      const Gap(20),
      TextBold("Start Vetting",
        color:Theme.of(context).colorScheme.brightness == Brightness.light ? AppColors.background : AppColors.white,
        fontSize: 19,
        fontWeight: FontWeight.w600,
      ),
      const Gap(10),
      TextSemiBold(
        "Welcome! No vetting forms yet. Click below to start.",
        color: const Color(0xff666666),
        textAlign: TextAlign.center,
      ),
      const Gap(35),
      BusyButton(title: "Create Form", onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateVettingScreen()),
        );
      })
    ],
  );
}
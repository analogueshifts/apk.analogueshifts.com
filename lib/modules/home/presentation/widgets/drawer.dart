import 'package:analogue_shifts_mobile/app/notifier/app_notifier.dart';
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/styles/fonts.dart';
import 'package:analogue_shifts_mobile/app/widgets/custom_single_chile_scroll_view.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/constants/fonts.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/functions.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/edit_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

@override
  void initState() {
  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, UserViewModel user, child) {
        final name = Functions.capitalize(user.authState.user?.name ?? "");
        final splitName = name.split(' ');
        final firstName = splitName[0];
      return AbsorbPointer(
        absorbing: user.authState.isGenerating,
        child: CustomSingleChildScrollView(
          key: _scaffoldkey,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.brightness ==Brightness.light ?  AppColors.white : AppColors.background
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.1, color: Theme.of(context).colorScheme.brightness ==Brightness.light ?  AppColors.grey : AppColors.white))
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
                          child: SvgPicture.asset(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/icons/close_icon.svg" : "assets/images/close-icon-white.png"))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        user.authState.user?.profile == null ? const Icon(Icons.verified_user) : CachedNetworkImage(
                          imageUrl: user.authState.user?.profile ?? "",
                          placeholder: (context, url) => SizedBox(width: 40.w, height:30, child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        // Image.asset("assets/images/Avatar Image.png", width: 40.w,),
                        const Gap(5),
                        TextBold("Hello, ${firstName}", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        )),
                        const Gap(3),
                        TextSemiBold("@${user.authState.user?.username ?? ""}", style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 9
                        ),),
                        // Gap(10)
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/avatar_image.png" : "assets/images/profile-black.png"), width: 35.w,height: 35.h,),
                title: Text('My Profile', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600
                ),),
                onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen()
                    ),
            );
                },
              ),
              
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/document.png" : "assets/images/document-black.png"), width: 35.w,height: 35.h,),
                title: Text('Vetting System', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600
                ),),
                onTap: () {
                  Navigator.pushNamed(context, Routes.vetting);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                 leading: Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/card.png" : "assets/images/card-black.png"), width: 35.w,height: 35.h,),
                title: Row(
                  children: [
                    Text('Payment Gateway', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600
                    ),),
                    const Gap(2),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xffD399AF).withOpacity(0.14),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Text("Coming Soon", style: TextStyle(
                        color: Color(0xffE16592),
                        fontSize: 8
                      ),),
                    )
                  ],
                ),
                // onTap: () {
                // },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/write.png" : "assets/images/write-black.png"), width: 35.w,height: 35.h,),
                title: Text('Help Center', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600
                ),),
                onTap: () {
                  Navigator.pushNamed(context, Routes.helpCenter);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/moon.png" : "assets/images/moon-balck.png"), width: 35.w,height: 35.h,),
                title: Text('Dark Mode', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600
                ),),
                trailing: Consumer<AppChangeNotifier>(
                   builder: (context, app, child) {
                  return Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      value: app.isDarkMode,
                      activeColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xffEBEBEB).withOpacity(0.5) : AppColors
                      .primaryColor,
                      activeTrackColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Color(0xff000000).withOpacity(0.06) : AppColors
                      .primaryColor,
                      onChanged: (bool value) {
                        // if(mounted == false)return;
                        // setState(() {
                        //   biometrics = value;
                          Logger().d(value);
                          context.read<AppChangeNotifier>().toggleTheme(value);
                        // });
                      },
                    ),
                  );
                   }
                ),
                // onTap: () {
                // },
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
                leading: Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/star.png" : "assets/images/star-black.png"), width: 35.w,height: 35.h,),
                title: Text('Rate Us', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600
                ),),
                onTap: () {
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image(image: AssetImage(Theme.of(context).colorScheme.brightness == Brightness.light ? "assets/images/logout.png" : "assets/images/logout-black.png"), width: 35.w,height: 35.h,),
                title: Text('Log Out', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600
                ),),
                onTap: () {
                  if(_scaffoldkey.currentContext == null)return;
                  showDialog(
                    barrierColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.transparent .withOpacity(0.6) : Color(0xff110C00).withOpacity(0.8),
                    context: _scaffoldkey.currentContext!, builder:(context) {
                 return dialog(context);
               },);
                },
              ),
            ],
              ),
          ),
        ),
      );
      }
    );
  }

   Widget dialog(BuildContext context) {
    bool _isProcessing = false;
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: AbsorbPointer(
       absorbing: _isProcessing,
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
                          //  Navigator.pop(context);
                          Navigator.pop(context);
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
                              //  context.pop();
                              await user.logoutUser(context).then((value) {
                                logger.d(value);
                               SchedulerBinding.instance.addPostFrameCallback((_) async {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.authenticate,
                                    (Route<dynamic> route) => false);
                              });
                                
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
                                    width: 25.w,
                                    child: const CircularProgressIndicator()) : const Text(
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
      ),
    );
  }
}
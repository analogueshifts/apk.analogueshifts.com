import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/widgets/touch_opacirty.dart';
import 'package:analogue_shifts_mobile/core/constants/app_widgets.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:analogue_shifts_mobile/core/navigators/navigation_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/Event/presentation/views/events.dart';
import 'package:analogue_shifts_mobile/modules/auth/data/models/login_response.model.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_view.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/drawer.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/job_view.dart';
import 'package:analogue_shifts_mobile/modules/notification/presentation/notifiers/notification_provider.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/profile_view.dart';
import 'package:analogue_shifts_mobile/modules/vetting/presentation/view/vetting_system.screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeNavigation extends StatefulWidget {
  int selectedIndex;
  HomeNavigation({super.key, this.selectedIndex = 0});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  // int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        widget.selectedIndex = index;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _onItemTapped(widget.selectedIndex!);
    context.read<UserViewModel>().init();
     WidgetsBinding.instance.addPostFrameCallback((_){
      if(mounted){
        context.read<UserViewModel>().fetchUser(context);
        context.read<JobProvider>().getJobs(context);
        context.read<JobProvider>().get_reconmended_jobs(context);
      }
    });

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    if(!mounted)return;

    _firebaseMessaging.requestPermission();

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        logger.d(message.notification?.title);

        final nav = getIt<NavigationService>();
        final navigatorState = nav.navigatorKey.currentState;
        // if(_scaffoldkey.currentContext == null)return;
        showDialog(
            barrierColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.transparent .withOpacity(0.6) : const Color(0xff110C00).withOpacity(0.8),
            context: context, builder:(context) {
          final theme = Theme.of(context).colorScheme.brightness;
          return Dialog(
            insetPadding: const EdgeInsets.all(30),
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
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(theme == Brightness.light ? "assets/icons/Bell.svg" : "assets/icons/Bell-light.svg"),
                            const Gap(35),
                            Text(
                              "${message.notification?.title}",
                              style: TextStyle(
                                // fontFamily: AppFonts.mulishRegular,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                // color: AppColors.black,
                              ),
                            ),
                            const Gap(18),
                            Text(
                              "${message.notification?.body}",
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
                        const Gap(16),
                        TouchableOpacity(
                          onTap: () async {
                             nav.navigatorKey.currentState?.pop();

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
                                child: const Text(
                                  "Dismiss",
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

          //   showDialog(
          //       context: context,  // Use the global key to get the current context
          //       builder: (BuildContext context) => AlertDialog(
          //           title: Text(message.notification?.title ?? 'Notification'),
          //           content: Text(message.notification?.body ?? 'No content'),
          //           actions: [
          //           TextButton(
          //           onPressed: () => Navigator.of(context).pop(),
          // child: Text('OK'),
          // )
          // ],
          // ),
          // );
          // }
        }
          );
        }
    });
  }


  @override
  Widget build(BuildContext context) {
    final savedUser = Provider.of<UserViewModel>(context,listen: true).authState;
    bool isLightMode = Theme.of(context).colorScheme.brightness == Brightness.light;
    final tabs = [
      const HomeView(),
      const JobScreen(),
      const EventsView(),
      const VettingSystemScreen()
    ];
    return  Consumer<UserViewModel>(

      builder: (context, UserViewModel user, child) {
        logger.e(savedUser.user);
      return savedUser.user == null ? Scaffold(
          body: Center(child: AppWidgets().logoSpinner)) : Scaffold(
        drawer: const Drawer(
      
          shape: RoundedRectangleBorder(),
      child: DrawerWidget()
        ),
        backgroundColor: Colors.transparent,
        body: tabs[widget.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 10,
          selectedLabelStyle: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.manRope
          ),
          unselectedLabelStyle: TextStyle(
              color: isLightMode ? const Color(0xffB0B0B0) : const Color(0xffB0B0B0)
          ),
          selectedFontSize: 10,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAsset.homeIcon, width: screenWidth(context) * 0.06,),
              activeIcon: SvgPicture.asset(AppAsset.homeActiveIcon, width: screenWidth(context) * 0.06,),
              label: 'Home',

            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAsset.bagIcon, width: screenWidth(context) * 0.06,),
              activeIcon: SvgPicture.asset(AppAsset.bagActiveIcon, width: screenWidth(context) * 0.06,),
              label: 'Jobs',
            ),
        
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAsset.invoiceIcon, width: screenWidth(context) * 0.06,),
              activeIcon: SvgPicture.asset(AppAsset.invoiceActiveIcon, width: screenWidth(context) * 0.06,),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/checkmark-badge-03.svg", width: screenWidth(context) * 0.06,),
              activeIcon: SvgPicture.asset("assets/images/checkmark-badge-active.svg", width: screenWidth(context) * 0.06,),
              label: 'Vetting System',
            ),
          ],
        ),
      );
      }
    );
  }
}
import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/app_widgets.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/modules/blog/presentation/views/blog_view.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_view.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/drawer.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/change_notifier/job_provider.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/job_view.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({Key? key}) : super(key: key);

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _onItemTapped(_selectedIndex);
     WidgetsBinding.instance.addPostFrameCallback((_){
      if(mounted){
        context.read<UserViewModel>().fetchUser(context);
        context.read<JobProvider>().getJobs(context);
        
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final tabs = [
      const HomeView(),
      const JobView(),
      const BlogView(),
      const ProfileView()
    ];
    return  Consumer<UserViewModel>(
      builder: (context, UserViewModel user, child) {
        logger.d('from dashbaord ===->>> ${user.authState.user?.email}');
      return user.authState.user == null ? Scaffold(body: Center(child: AppWidgets().logoSpinner)) : Scaffold(
        drawer: Drawer(
      
          shape: RoundedRectangleBorder(),
      child: DrawerWidget()
        ),
        // backgroundColor: ,
        body: tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 12,
          selectedFontSize: 12,
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
              label: 'Blogs',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAsset.userIcon, width: screenWidth(context) * 0.06,),
              activeIcon: SvgPicture.asset(AppAsset.userActiveIcon, width: screenWidth(context) * 0.06,),
              label: 'Account',
            ),
          ],
        ),
      );
      }
    );
  }
}
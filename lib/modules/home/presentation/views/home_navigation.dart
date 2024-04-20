import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/modules/blog/presentation/views/blog_view.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/views/home_view.dart';
import 'package:analogue_shifts_mobile/modules/home/presentation/widgets/drawer.dart';
import 'package:analogue_shifts_mobile/modules/jobs/presentation/views/job_view.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  // @override
  // void dispose() {
  //   _onItemTapped(_currentIndex);
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    _onItemTapped(_selectedIndex);
  }

  // @override
  // void dispose() {
  //   if (mounted) {
  //     _onItemTapped(_selectedIndex);
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const HomeView(),
      const JobView(),
      const BlogView(),
      const ProfileView()
    ];
    return Scaffold(
      drawer: const Drawer(
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
}
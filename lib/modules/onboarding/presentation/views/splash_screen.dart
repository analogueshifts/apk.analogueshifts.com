import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/app_asset.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/ui_helpers.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upgrader/upgrader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _db = getIt<DBService>();
  Future<void> _toOnboard() async {
    _db.getToken();
    if(_db.get('onboard') == null){
      Navigator.popAndPushNamed(context, Routes.introduction);
    }else{
      if (_db.getToken() != null){
        logger.d(_db.getToken());
        Navigator.popAndPushNamed(context, Routes.homeNavigation);
      }else{
         Navigator.popAndPushNamed(context, Routes.authenticate);
      }
    }
    // logger.d(db);

  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), _toOnboard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight(context);
    return UpgradeAlert(
      child: Scaffold(
        body: Center(child:  SizedBox(
          width: 150,
          height: 150,
          child: Image.asset(Theme.of(context).colorScheme.brightness == Brightness.light ? AppAsset.logo : "assets/images/logo-black.png").animate(
              onPlay: (controller) =>
                  controller.repeat(reverse: true))
              .shimmer(
              delay: 200.ms,
              duration: 1200.ms,
              color: AppColors.primaryColor.withOpacity(.4)).shake(hz: 4, curve: Curves.easeInOutCubic).scaleXY(end: 1.1, duration: 600.ms)
              .then(delay: 600.ms)
              .scaleXY(end: 1 / 1.1),
        ))
      ),
    );
  }
}
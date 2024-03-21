import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/app_widgets.dart';
import 'package:analogue_shifts_mobile/modules/onboarding/presentation/views/introduction._screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _toOnboard() async {
    // context.goNamed(Routes.authenticate);
    // MaterialApp.router
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => IntroductionScreen()),
            (Route<dynamic> route) => true);
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), _toOnboard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
      ),
      body: Center(child:  SizedBox(
        width: 150,
        height: 150,
        child: AppWidgets().logoIcon .animate(
            onPlay: (controller) =>
                controller.repeat(reverse: true))
            .shimmer(
            delay: 200.ms,
            duration: 1200.ms,
            color: AppColors.primaryColor.withOpacity(.4)).shake(hz: 4, curve: Curves.easeInOutCubic).scaleXY(end: 1.1, duration: 600.ms)
            .then(delay: 600.ms)
            .scaleXY(end: 1 / 1.1),
      ))
    );
  }
}
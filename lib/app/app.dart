import 'package:analogue_shifts_mobile/app/theme/light_theme.dart';
import 'package:analogue_shifts_mobile/core/navigators/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AnalogueApp extends StatelessWidget {
  const AnalogueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        // themeMode: ThemeMode.white,
        // initialRoute: Routes.splash,
        // onGenerateRoute: generateRoute,
      ),
    );
  }
}
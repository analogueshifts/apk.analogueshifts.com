import 'package:analogue_shifts_mobile/app/theme/light_theme.dart';
import 'package:analogue_shifts_mobile/core/navigators/go_router.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class AnalogueApp extends StatelessWidget {
  const AnalogueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:providers,
      child: MaterialApp.router(
        routeInformationProvider:
        getIt<GoRouter>().routeInformationProvider,
        routeInformationParser: getIt<GoRouter>().routeInformationParser,
        routerDelegate: getIt<GoRouter>().routerDelegate,
        backButtonDispatcher: getIt<GoRouter>().backButtonDispatcher,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        // themeMode: ThemeMode.white,
        // initialRoute: Routes.splash,
        // onGenerateRoute: generateRoute,
      ),
    );
  }
}
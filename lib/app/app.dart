import 'package:analogue_shifts_mobile/app/notifier/app_notifier.dart';
import 'package:analogue_shifts_mobile/app/theme/dark_theme.dart';
import 'package:analogue_shifts_mobile/app/theme/light_theme.dart';
import 'package:analogue_shifts_mobile/core/navigators/go_router.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/navigators/router.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/firebase_handler.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:analogue_shifts_mobile/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


class AnalogueApp extends StatefulWidget {
  const AnalogueApp({super.key});

  @override
  State<AnalogueApp> createState() => _AnalogueAppState();
}

class _AnalogueAppState extends State<AnalogueApp> {
  final messagingService = PushNotificationService();

  @override
  void initState() {
    messagingService.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:providers,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
        child: Consumer<AppChangeNotifier>(
           builder: (context, AppChangeNotifier appNotifier, child) {
            Logger().d(appNotifier.isDarkMode);
          Logger().i(getIt<AppChangeNotifier>().isDarkMode);
          return MaterialApp(
            // routeInformationProvider:
             initialRoute: Routes.startUp,
            onGenerateRoute: generateRoute,
            // getIt<GoRouter>().routeInformationProvider,
            // routeInformationParser: getIt<GoRouter>().routeInformationParser,
            // routerDelegate: getIt<GoRouter>().routerDelegate,
            // backButtonDispatcher: getIt<GoRouter>().backButtonDispatcher,
            debugShowCheckedModeBanner: false,
            // themeMode:  getIt<AppChangeNotifier>().isDarkMode != null && true ? ThemeMode.dark : ThemeMode.light,
            // darkTheme: darkTheme,
            
            theme: getIt<AppChangeNotifier>().isDarkMode == true ? darkTheme : lightTheme
            // theme: appNotifier.isDarkMode == null || appNotifier.isDarkMode == false && getIt<AppChangeNotifier>().isDarkMode  == false  ? lightTheme : darkTheme
          );
           }
        ),
      ),
    );
  }
}
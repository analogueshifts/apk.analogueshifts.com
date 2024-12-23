import 'package:analogue_shifts_mobile/app/notifier/app_notifier.dart';
import 'package:analogue_shifts_mobile/app/theme/dark_theme.dart';
import 'package:analogue_shifts_mobile/app/theme/light_theme.dart';
import 'package:analogue_shifts_mobile/core/navigators/navigation_service.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/navigators/router.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/snackbar.dart';
import 'package:analogue_shifts_mobile/firebase_handler.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/providers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class AnalogueApp extends StatefulWidget {
  const AnalogueApp({super.key});

  @override
  State<AnalogueApp> createState() => _AnalogueAppState();
}

class _AnalogueAppState extends State<AnalogueApp> {
  final messagingService = PushNotificationService();


void updateState(bool value){
  if(!mounted)return;
  setState(() {
  });
}


  @override
  void initState() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
   if(!mounted)return;
  
    messagingService.initialize(context);
   _firebaseMessaging.requestPermission();
   print(messagingService.getToken().then((value) => logger.d(value)));

   // Listen for foreground messages

    super.initState();
  }
  // static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final _db = getIt<DBService>();

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
          return MaterialApp(
             initialRoute: Routes.startUp,
            onGenerateRoute: generateRoute,
            navigatorKey: getIt<NavigationService>().navigatorKey,
          themeMode:  _db.getTheme() ?? ThemeMode.system,
          darkTheme: _db.getTheme() == null? ThemeData.dark() : (_db.getTheme() == ThemeMode.light? lightTheme : darkTheme),
            debugShowCheckedModeBanner: false,
          );
           }
        ),
      ),
    );
  }
}
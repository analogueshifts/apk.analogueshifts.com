import 'package:analogue_shifts_mobile/core/notificaton/local_notification_service.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseHandler {
 Future<void> init() async{
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

    // Enable Crashlytics in release mode
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken().then((value) {

  }

  ).catchError((e) => logger.e(e));
   // debugPrint("FCMToken $fcmToken");
    await getIt<DBService>().saveFirebaseToken(fcmToken.toString());
  }




}


class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {

      if (message?.notification != null) {
        LocalNtificationService().showLocalNotification(message!.notification!);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

      if (message.notification != null) {
      }
    });
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    return token;
  }

  Future<void> backgroundHandler(RemoteMessage message) async {
    
}
}
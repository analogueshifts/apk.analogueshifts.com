import 'package:analogue_shifts_mobile/core/notificaton/local_notification_service.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseHandler {
  init() async{
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
   debugPrint("FCMToken $fcmToken");
    await getIt<DBService>().saveFirebaseToken(fcmToken.toString());
  }
  
  
}




// class LocalNotificationService {
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future<void> init() async {
//     // Initialize native android notification
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     // Initialize native Ios Notifications
//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings();
//
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );
//   }
//
//   Future<void> showNotification(RemoteNotification? notification) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       notification!.hashCode.toString(),
//       'general',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     const iosNotificatonDetail = DarwinNotificationDetails();
//      var notificationDetails = NotificationDetails(
//       iOS: iosNotificatonDetail,
//       android: androidPlatformChannelSpecifics,
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification?.title,
//       notification?.body,
//       notificationDetails,
//       payload: 'item x',
//     );
//   }
// }
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
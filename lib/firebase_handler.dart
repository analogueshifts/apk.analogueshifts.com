import 'dart:io';

import 'package:analogue_shifts_mobile/core/notificaton/local_notification_service.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  /// Initializes Firebase Messaging, requests permissions, and sets up listeners.
  Future<void> initialize(BuildContext context) async {
    // Request notification permissions and await the result.
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    // If running on iOS, retrieve and log the APNS token.
    if (Platform.isIOS) {
      String? apnsToken = await _fcm.getAPNSToken();
      if (apnsToken != null) {
        print('APNS Token: $apnsToken');
      } else {
        print('APNS token is not available yet.');
      }
    }

    // Set up foreground message listener.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        // Display a local notification or handle it as needed.
        LocalNtificationService().showLocalNotification(message.notification!);
      }
    });

    // Set up the listener for when a user taps on a notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        // Handle navigation or other logic when notification is opened.
      }
    });

    // Set the background message handler.
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  /// Retrieves the FCM token (after ensuring that notification permissions
  /// and APNS token (on iOS) are set).
  Future<String?> getToken() async {
    // Optionally, you could retrieve and log the APNS token here again.
    if (Platform.isIOS) {
      String? apnsToken = await _fcm.getAPNSToken();
      print('APNS Token before getting FCM token: $apnsToken');
    }


    if (Platform.isAndroid) {
       String? token = await _fcm.getToken();
        print('FCM Token: $token');
    return token;
    }

   
  }

  /// Background message handler must be a top-level or static function.
  static Future<void> backgroundHandler(RemoteMessage message) async {
  }
}


// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;

//   Future initialize(BuildContext context) async {
//     FirebaseMessaging.instance.requestPermission();
//     FirebaseMessaging.onMessage.listen((RemoteMessage? message) {

//       if (message?.notification != null) {
//         LocalNtificationService().showLocalNotification(message!.notification!);
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

//       if (message.notification != null) {
//       }
//     });
//     FirebaseMessaging.onBackgroundMessage(backgroundHandler);

//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //     if (message.notification != null) {
//   //       // Display an alert when notification is received in foreground
//   //       showDialog(
//   //         context: context,
//   //         builder: (context) => AlertDialog(
//   //           title: Text(message.notification!.title ?? 'Notification'),
//   //           content: Text(message.notification!.body ?? 'No content'),
//   //           actions: [
//   //             TextButton(
//   //               onPressed: () => Navigator.pop(context),
//   //               child: Text('OK'),
//   //             ),
//   //           ],
//   //         ),
//   //       );
//   //     }
//   //   });
//   }

//   Future<String?> getToken() async {

    
//     String? token = await _fcm.getToken();
//     return token;
//   }

//   Future<void> backgroundHandler(RemoteMessage message) async {
    
// }
// }
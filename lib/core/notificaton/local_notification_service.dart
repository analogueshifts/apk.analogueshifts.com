import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNtificationService {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    const androidInitializationSetting =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSetting = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
        android: androidInitializationSetting, iOS: iosInitializationSetting);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  void showLocalNotification(RemoteNotification notification) {
    var androidNotificationDetail = AndroidNotificationDetails(
        notification.hashCode.toString(), // channel Id
        'general' // channel Name
    );
    const iosNotificatonDetail = DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
      iOS: iosNotificatonDetail,
      android: androidNotificationDetail,
    );
    _flutterLocalNotificationsPlugin.show(notification.hashCode,
        notification.title,
        notification.body, notificationDetails);
  }
}
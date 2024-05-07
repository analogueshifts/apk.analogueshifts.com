import 'package:analogue_shifts_mobile/app/app.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 Future<void> backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await ScreenUtil.ensureScreenSize();
  runApp(const AnalogueApp());
}
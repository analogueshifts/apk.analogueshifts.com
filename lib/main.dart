import 'package:analogue_shifts_mobile/app/app.dart';
import 'package:analogue_shifts_mobile/core/notificaton/local_notification_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/core/utils/stem_utils.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

 Future<void> backgroundHandler(RemoteMessage message) async {
  logger.d('Handling a background message ${message.notification?.title}');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupDependencies();
  SystemUtil.overrideNavColors();
  SystemUtil.disableLandscapeMode();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await LocalNtificationService().setup();
  await ScreenUtil.ensureScreenSize();
  runApp(const AnalogueApp());
}
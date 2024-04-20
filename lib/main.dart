import 'package:analogue_shifts_mobile/app/app.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  await ScreenUtil.ensureScreenSize();
  runApp(const AnalogueApp());
}
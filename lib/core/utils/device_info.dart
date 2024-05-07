import 'dart:io';

import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
// import 'package:device_info_plus/device_info_plus.dart';


class DeviceInfo {
  int  getDeviceType() {
    if(Platform.isIOS){
      return 2;
    }else if(Platform.isAndroid){
      return 1;
    }
    return 0;
  }

}
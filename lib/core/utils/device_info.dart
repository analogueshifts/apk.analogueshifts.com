import 'dart:io';


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
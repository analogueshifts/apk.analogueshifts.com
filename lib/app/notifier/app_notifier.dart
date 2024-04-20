import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AppChangeNotifier extends ChangeNotifier {
 bool? _isDarkMode;
 bool? get isDarkMode => _isDarkMode;
  final _db = getIt<DBService>();
  

  void toggleTheme(bool value){
    Logger().d(value);
    _isDarkMode = value;
    notifyListeners();
    _db.saveTheme(value);
     notifyListeners();
   
  }



  initAppTheme() async {
   bool? theme = await _db.getTheme();
   if(theme == null)return;
   _isDarkMode = theme;
   Logger().d('Notifier Teme $isDarkMode');
   toggleTheme(theme);
   notifyListeners();
}
}


class AppState {


}
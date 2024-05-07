import 'package:analogue_shifts_mobile/app/notifier/app_settings.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AppChangeNotifier extends ChangeNotifier {
  final _db = getIt<DBService>();


  ThemeMode _themeMode = ThemeMode.dark;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;


  changeTheme(ThemeMode value){
    _themeMode = value;
    notifyListeners();
  }
  // void toggleTheme(bool value){
  //   Logger().d(value);
  //   if (_isDarkMode == null) {
  //     _isDarkMode = _db.getTheme();
  //   }
  //   _isDarkMode = !_isDarkMode!;
  //   logger
  //   .d('from toggle theme${_isDarkMode}');
  //   _db.saveTheme(_isDarkMode!);
  //    notifyListeners();
   
  // }



  initAppTheme() async {
  _themeMode = ThemeMode.system;
  notifyListeners();
   bool? theme = await _db.getTheme();
   logger.e(
    theme
   );
   if(theme == null){
    logger.d('running no theme ${theme}');
    _themeMode = ThemeMode.system;
    notifyListeners();
    //  toggleTheme(ThemeMode.system == ThemeMode.dark ? true : false);
   }else{
    if (theme == true) {
      _themeMode = ThemeMode.dark;
    }else{
        _themeMode = ThemeMode.light;
    }
    //  _themeMode = theme == true ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  //  toggleTheme(theme);
  //  notifyListeners();
   }
} 
}


class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService
   _settingsService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }
}
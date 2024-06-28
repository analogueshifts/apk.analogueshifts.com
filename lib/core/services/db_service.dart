import 'package:analogue_shifts_mobile/core/services/hive_user_adapter.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';


class DBService {
  static const String box = "_db-analog";
  var log = Logger();
  static const String boxName = "user_box"; 

  Future<void> startHive() async {
    
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ThemeModeAdapter());
    await Hive.openBox<User>(boxName);
    if(this.getUser(0) != null){
      await this.removeUser(0);
    }

    await Hive.openBox(box);
    
    // if(getTheme() == null){
    //   Logger().d('runnedekj nullsjwe');
    //   await saveTheme(false);
    // }
    
    log.d("Hive Service Started");
  }

  Box getBox() {
    return Hive.box(box);
  }

  Future<void> save(String key, dynamic value) async {
    final box = getBox();
    await box.put(key, value);
  }

  Future<void> saveFirebaseToken(String value) async {
    final box = getBox();
    await box.put("_firebase-token", value);
  }

  Future<void> saveToken(String value) async {
    final box = getBox();
    await box.put("_db-token", value);
  }

   Future<void> saveTheme(ThemeMode value) async {
    final box = getBox();
    Logger().d('saved themed $value');
    await box.put("_theme", value);
  }

  ThemeMode? getTheme() {
    final box = getBox();
    var value = box.get("_theme");
    return value;
  }


  dynamic get(String key) {
    final box = getBox();
    var value = box.get(key);
    return value;
  }


  String? getToken() {
    final box = getBox();
    var value = box.get("_db-token");
    return value;
  }


  String? getFirebaseToken() {
    final box = getBox();
    var value = box.get("_firebase-token");
    return value;
  }

  Future<void> remove(String key) async {
    final box = getBox();
    await box.delete(key);
  }


  Future<void> removeAuthToken() async {
    final box = getBox();
    await box.delete('_db-token');
  }

  Future<void> clear() async {
    final box = getBox();
    await box.clear();
  }

   Future<void> saveUser(User user) async {
    final box = Hive.box<User>('user_box');
    await box.put(0, user); // Use id as key
  }

  User? getUser(int id) {
    final box = Hive.box<User>("user_box");
    logger.d(box);
    return box.get(id); // Retrieve user by id
  }

  Future<void> removeUser(int id) async {
    final box = Hive.box<User>("user_box");
    await box.delete(id); // Remove user by id
  }
}

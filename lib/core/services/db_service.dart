import 'dart:convert';

import 'package:analogue_shifts_mobile/core/services/hive_user_adapter.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';


class DBService {
  static const String box = "_db-analog";
  var log = Logger();
  static const String boxName = "user_box"; 

  Future<void> startHive() async {
    
    await Hive.initFlutter();
    // Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ThemeModeAdapter());
    // await Hive.openBox<User>(boxName);
    // if(this.getUser(0) != null){
    //   await this.removeUser(0);
    // }

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


  final _storage = new FlutterSecureStorage();


  final String _userKey = 'user_data';

  Future<void> saveUser(User user) async {
    final userJson = jsonEncode(user.toJson());
    await _storage.write(key: _userKey, value: userJson);
  }

  Future<User?> getUser() async {
    final userJson = await _storage.read(key: _userKey);
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  Future<void> deleteUser() async {
    await _storage.delete(key: _userKey);
  }


  // Create storage






// Write value

}

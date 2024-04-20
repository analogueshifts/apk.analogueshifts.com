import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';


class DBService {
  static const String box = "_db-analog";
  var log = Logger();

  Future<void> startHive() async {
    await Hive.initFlutter();
    await Hive.openBox(box);
    if(getTheme() == null){
      Logger().d('runnedekj nullsjwe');
      await saveTheme(false);
    }
    
    log.d("Hive Service Started");
  }

  Box getBox() {
    return Hive.box(box);
  }

  Future<void> save(String key, dynamic value) async {
    final box = getBox();
    await box.put(key, value);
  }

  Future<void> saveToken(String value) async {
    final box = getBox();
    await box.put("_db-token", value);
  }

   Future<void> saveTheme(bool value) async {
    final box = getBox();
    Logger().d('saved themed ${value}');
    await box.put("_theme", value);
  }

  bool? getTheme() {
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

  Future<void> remove(String key) async {
    final box = getBox();
    await box.delete(key);
  }

  Future<void> clear() async {
    final box = getBox();
    await box.clear();
  }
}

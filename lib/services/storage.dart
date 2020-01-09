import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<SharedPreferences> get dB async {
    final dbInst = await SharedPreferences.getInstance();
    return dbInst;
  }

  static setItem({String key, dynamic val}) async {
    final db = await dB;
    if (val is int) {
      await db.setInt(key, val);
    } else if (val is bool) {
      await db.setBool(key, val);
    } else if (val is double) {
      await db.setDouble(key, val);
    } else if (val is List<String>) {
      await db.setStringList(key, val);
    } else if (val is String) {
      await db.setString(key, val);
    } else {
      await db.setString(key, val.toString());
    }
  }

  static dynamic getItem({String key}) async {
    final db = await dB;
    if (db.containsKey(key)) {
      return db.get(key);
    }
    return null;
  }

  static removeItem({String key}) async {
    final db = await dB;
    if (db.containsKey(key)) {
      await db.remove(key);
      return "removed";
    }
    return;
  }

  static clearItems() async {
    final db = await dB;
    await db.clear();
  }
}

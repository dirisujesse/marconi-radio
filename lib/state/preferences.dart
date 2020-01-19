import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:marconi_radio/models/station.dart';
import 'package:marconi_radio/services/hive.dart';

class PrefsState extends ChangeNotifier {
  LocalStorage favDb = LocalStorage();
  LocalStorage recDb = LocalStorage(store: "recent");
  static PrefsState instance;

  static PrefsState getInstance() {
    if (instance == null) {
      instance = PrefsState();
    }
    return instance;
  }

  Future<List<dynamic>> get favourites async {
    try {
      return await favDb.getAll();
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> get recent async {
    try {
      return await recDb.getAll();
    } catch (e) {
      return null;
    }
  }

  add(Station station, {bool isFav = true}) async {
    final db = isFav ? favDb : recDb;
    if (!isFav) {
      final haskey = db.db.containsKey(station.id);
      if (haskey) {
        await db.db.delete(station.id);
      }
      final recLen = db.db.length;
      if (recLen == 30) {
        await db.db.deleteAt(0);
      }
      await db.setItem(key: station.id, value: station.toJson());
      notifyListeners();
      return;
    }
    await db.setItem(key: station.id, value: station.toJson());
    notifyListeners();
  }

  remove(String key, {bool isFav = true}) async {
    final db = isFav ? favDb : recDb;
    await db.removeItem(key: key);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

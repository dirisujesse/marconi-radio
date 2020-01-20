import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:marconi_radio/services/channels.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/styles/colors.dart';

Future<bool> popHandler(context) async {
  final db = Hive.box("usrData");
  bool hasRatedApp = db.get("hasRated");
  int nextRateDay = db.get("rateDay");
  int curMillis = DateTime.now().millisecondsSinceEpoch;
  int tenDaysMillis =
      DateTime.now().add(Duration(days: 10)).millisecondsSinceEpoch;
  if ((hasRatedApp == null || hasRatedApp == false) &&
      (nextRateDay == null || curMillis >= nextRateDay ?? 0)) {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Rate Marconi Radio"),
          content: Text(
            "If you have enjoyed using Marconi Radio please consider rating it",
          ),
          actions: <Widget>[
            FlatButton(
              textColor: appBlack,
              child: Text("Remind me later"),
              onPressed: () {
                db.put("hasRated", false);
                db.put("rateDay", tenDaysMillis);
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text("Rate Now"),
              color: appBlack,
              onPressed: () async {
                NativeCaller.instance.rate();
                db.put("hasRated", true);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return false;
  } else {
    final bool shouldPop = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Do you want exit marconi radio?"),
          actions: <Widget>[
            FlatButton(
              textColor: appBlack,
              child: Text("Yes"),
              onPressed: () {
                PlayerState.getInstance().stop();
                Navigator.of(context).pop(true);
              },
            ),
            RaisedButton(
              child: Text("No"),
              color: appBlack,
              onPressed: () async {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
    return shouldPop;
  }
}

class LocalStorage {
  String store;

  LocalStorage({this.store = "favourites"});

  LazyBox get db {
    try {
      final data = Hive.lazyBox(store);
      return data;
    } catch (e) {
      throw e;
    }
  }

  Future<List<dynamic>> getAll() async {
    try {
      final keys = db.keys.toList();
      List<dynamic> data = [];
      for (var i = 0; i < keys.length; i++) {
        final station = await db.get(keys[i]) as dynamic;
        data.add(station);
      }
      return data;
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> getItem({String key}) async {
    try {
      final data = await db.get(key);
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<String> setItem({String key, dynamic value}) async {
    try {
      await db.put(key, value);
      return "saved";
    } catch (e) {
      return null;
    }
  }

  Future<String> removeItem({String key}) async {
    try {
      await db.delete(key);
      return "removed";
    } catch (e) {
      return null;
    }
  }

  clear() async {
    try {
      final data = await db.clear();
      return data;
    } catch (e) {
      return null;
    }
  }
}

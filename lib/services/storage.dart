// import 'package:shared_preferences/shared_preferences.dart';

// class StorageService {
//   static Future<SharedPreferences> get dB async {
//     final dbInst = await SharedPreferences.getInstance();
//     return dbInst;
//   }

//   static setItem({String key, dynamic val}) async {
//     final db = await dB;
//     switch(val.runtimeType) {
//       case 'int':
//         await db.setInt(key, val);
//         break;
//       case 'double':
//         await db.setDouble(key, val);
//         break;
//       case 'bool':
//         await db.setBool(key, val);
//         break;
//       case 'List<String>':
//         await db.setStringList(key, val);
//         break;
//       case 'String':
//         await db.setString(key, val);
//         break;
//       default:
//         await db.setString(key, val.toString());
//     } 
//   }

//   static dynamic getItem({String key}) async {
//     final db = await dB;
//     if (db.containsKey(key)) {
//       return db.get(key);
//     }
//     return Null;
//   }

//   static removeItem({String key}) async {
//     final db = await dB;
//     if (db.containsKey(key)) {
//       await db.remove(key);
//       return;
//     }
//     return;
//   }

//   static clearItems() async {
//     final db = await dB;
//     await db.clear();
//   }
// }
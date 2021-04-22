import 'package:hive/hive.dart';

class HiveService {
  // static String boxName;

  static Future get(String boxName) async {
    Box box = await Hive.openBox('$boxName');
    // int clear = await box.clear();
    // return clear;
    return box.toMap().isEmpty ? false : box.toMap();
  }

  static Future put({String boxName, data}) async {
    Box box = await Hive.openBox('$boxName');

    box.add(data);
    // data.forEach((value){
    //     box.add(value);
    // });
  }

  static Future clear(String boxName) async {
    Box box = await Hive.openBox(boxName);
    await box.clear();
  }
}

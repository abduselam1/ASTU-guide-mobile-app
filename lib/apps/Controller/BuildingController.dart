import 'package:astu_guide/common/services/Connection.dart';
import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class BuildingController {
  static Future updateCourse() async {
    if (await Connection().isConnected()) {
      try {
        Response response = await UrlService.get('buildings');
        await HiveService.clear('building');
        await HiveService.put(boxName: 'courses', data: response.data);
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }

  static Future searchForBuildings({String searchKeyWord}) async {
    var cacheBuilding = await HiveService.get('building');
    if (cacheBuilding == false) {
      if (await Connection().isConnected()) {
        try {
          Response response = await UrlService.get('buildings');
          // print(response.data);
          await HiveService.put(boxName: 'building', data: response.data);
        } catch (e) {
          print(e);
          return false;
        }
      } else {
        return false;
      }
    }

    var building = await HiveService.get('building');

    var filter = building[0].where((element) {
      String keyWord = searchKeyWord.trim();
      String building_number = element['building_number'].toString();
      if (building_number.contains(RegExp(keyWord)) ||
          element['building_name'].contains(RegExp(keyWord)) ||
          element['description'].contains(RegExp(keyWord))) {
        return true;
      }
      return false;
    });

    return filter.toList();
  }
}

import 'package:astu_guide/common/services/Connection.dart';
import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class EssentialInformationController {
  static Future updateDrivers() async {
    if (await Connection().isConnected()) {
      try {
        Response response =
            await UrlService.get('essential-informations/ambulances');
        await HiveService.clear('ambulance');
        await HiveService.put(boxName: 'ambulance', data: response.data);
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }

  static Future updateOffice() async {
    if (await Connection().isConnected()) {
      try {
        Response response =
            await UrlService.get('essential-informations/offices');
        await HiveService.clear('offices');
        await HiveService.put(boxName: 'offices', data: response.data);
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }

  Future getOfficeInfo() async {
    var officeFromCache = await HiveService.get('offices');
    if (officeFromCache == false) {
      if (await Connection().isConnected()) {
        try {
          Response response =
              await UrlService.get('essential-informations/offices');
          await HiveService.put(data: response.data, boxName: 'offices');
        } catch (e) {
          return false;
        }
      } else
        return false;
    }

    var office = await HiveService.get('offices');
    return office[0];
  }

  static Future ambulanceDrivers(String searchKeyWord) async {
    var cacheData = await HiveService.get('ambulance');

    if (cacheData == false) {
      print("cache not availble");
      if (await Connection().isConnected()) {
        /// connection checking
        Response response;
        try {
          response = await UrlService.get('essential-informations/ambulances');

          await HiveService.put(boxName: "ambulance", data: response.data);
        } catch (e) {
          print(e);
          return false;
        }
        //  print(response);
      }
      return false;
    }
    var ambulance = await HiveService.get('ambulance');
    print(ambulance);
    var filter = ambulance[0].where((element) {
      String keyWord = searchKeyWord.trim();
      if (element['driver_name'].contains(RegExp(keyWord)) ||
          element['phone_number'].contains(RegExp(keyWord))) {
        return true;
      }
      return false;
    });

    return filter.toList();
  }
}

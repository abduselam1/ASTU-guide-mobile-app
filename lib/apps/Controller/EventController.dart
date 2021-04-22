import 'package:astu_guide/common/services/Connection.dart';
import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class EventController{

  static Future updateCourse() async {
    if (await Connection().isConnected()) {
      try {
        Response response = await UrlService.get('academic-calendars');
        await HiveService.clear('academic-calendars');
        await HiveService.put(boxName: 'academic-calendars', data: response.data);
      } catch (e) {
        print(e);
        return false;
      }
    }else{
      return false;
    }
  }

  Future fetchEvents() async {
  try {
    var calenderFromCache = await HiveService.get('academic-calendars');
    if (calenderFromCache == false) {
      if (await Connection().isConnected()) {
        Response response = await UrlService.get('academic-calendars');
        await HiveService.put(
            boxName: 'academic-calendars', data: response.data);
      } else
        return false;
    }

    var academicCalender = await HiveService.get('academic-calendars');
    return academicCalender[0];
  } catch (e) {
    return false;
  }
}

}
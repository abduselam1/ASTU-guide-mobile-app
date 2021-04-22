import 'package:astu_guide/common/services/Connection.dart';
import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class RuleController {
  static Future rulesDataFromCache() async {
    var courses = await HiveService.get('rules');
    if (courses == false) {
      try {
        Response response = await UrlService.get('rules-and-regulations');
        await HiveService.clear('rules');
        await HiveService.put(boxName: 'rules', data: response.data);
      } catch (e) {
        print(e);
        return false;
      }
    }

    Map cacheCourses = await HiveService.get('rules');
    print(cacheCourses[0]);
    // String searchWord = searchKeyWord.trim();
    return cacheCourses[0];
    // var filtered =
    //     cacheCourses[0].where((course) => whereCallback(course, searchKeyWord));

    // return filtered.toList();
  }

  static bool whereCallback(course, searchKeyWord) {
    String creditHour = course['credit_hour'].toString();
    if (course['code']
            .toLowerCase()
            .contains(RegExp(searchKeyWord.trim().toLowerCase())) ||
        course['title'].toLowerCase().contains(RegExp(searchKeyWord.trim())) ||
        creditHour.toLowerCase().contains(RegExp(searchKeyWord.trim()))) {
      return true;
    }
    return false;
  }

  // static Future rulesDataFromCache() async {
  //   var rulesFromCache = await HiveService.get('rules');
  //   if (rulesFromCache == false) {
  //     var rulesFromDatabase = await fetchRulesAndRegulation();
  //     if (rulesFromDatabase == false) return false;

  //     await HiveService.put(boxName: 'rules', data: rulesFromDatabase);
  //   }

  //   Map rules = await HiveService.get('rules');
  //   print(rules);
  //   return rules[0];
  // }

  static Future fetchRulesAndRegulation() async {
    if (await Connection().isConnected()) {
      try {
        Response response = await UrlService.get('rules-and-regulations');

        if (response.data == null) {
          return false;
        } else {
          print(response.data[0]['id']);
          return response.data;
        }
      } catch (e) {
        print(e);
        return false;
      }
    } else
      return false;
  }
}

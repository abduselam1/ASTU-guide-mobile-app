import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class CourseCurriculumController{
  Future curriculum() async {
    try {
      var curriculaCache = await HiveService.get('curricula');
      if (curriculaCache == false) {
        Response response = await UrlService.get('curricula');
        await HiveService.put(boxName: 'curricula', data: response.data);
      }

      var curricula = await HiveService.get('curricula');
      return curricula[0];
    } catch (e) {
      print(e);
      return false;
    }
  }

  int coursesPerSemester(Map courses) {
    int semester = courses['semester'];

    return semester;
  }
  
  Map<String, List<List>> coursesPerYear(List courses) {
    Map<String, List<List>> program = {};
    List<List> firstYear = [[], [], []];
    List<List> secondYear = [[], [], []];
    List<List> thirdYear = [[], [], []];
    List<List> fourthYear = [[], [], []];
    List<List> fifthYear = [[], [], []];

    for (var i = 0; i < courses.length; i++) {
      int year = courses[i]['year'];

      switch (year) {
        case 1:
          int semester = coursesPerSemester(courses[i]);
          if (semester == 1) {
            firstYear[0].add(courses[i]);
          } else if (semester == 2)
            firstYear[1].add(courses[i]);
          else
            firstYear[2].add(courses[i]);
          break;
        case 2:
          // secondYear = coursesPerSemester(courses[i]);
          int semester = coursesPerSemester(courses[i]);
          if (semester == 1) {
            secondYear[0].add(courses[i]);
          } else if (semester == 2)
            secondYear[1].add(courses[i]);
          else
            secondYear[2].add(courses[i]);
          break;
        case 3:
          int semester = coursesPerSemester(courses[i]);
          if (semester == 1) {
            thirdYear[0].add(courses[i]);
          } else if (semester == 2)
            thirdYear[1].add(courses[i]);
          else
            thirdYear[2].add(courses[i]);
          // thirdYear = coursesPerSemester(courses[i]);
          break;
        case 4:
          int semester = coursesPerSemester(courses[i]);
          if (semester == 1) {
            fourthYear[0].add(courses[i]);
          } else if (semester == 2)
            fourthYear[1].add(courses[i]);
          else
            fourthYear[2].add(courses[i]);
          // fourthYear = coursesPerSemester(courses[i]);
          break;
        case 5:
          int semester = coursesPerSemester(courses[i]);
          if (semester == 1) {
            fifthYear[0].add(courses[i]);
          } else if (semester == 2)
            fifthYear[1].add(courses[i]);
          else
            fifthYear[2].add(courses[i]);
          // fifthYear = coursesPerSemester(courses[i]);
          break;
        default:
      }
    }

    // print(thirdYear[2]);
    // print('-------');
    // print(secondYear);
    program['firstYear'] = firstYear;
    program['secondYear'] = secondYear;
    program['thirdYear'] = thirdYear;
    program['fourthYear'] = fourthYear;
    program['fifthYear'] = fifthYear;
    // print(program);
    return program;
  }
}
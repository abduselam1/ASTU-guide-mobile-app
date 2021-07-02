import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class CourseCurriculumController {
  Future curriculum() async {
    try {
      var curriculaCache = await HiveService.get('curricula');
      if (curriculaCache == false) {
        Response response = await UrlService.get('curricula');
        await HiveService.put(boxName: 'curricula', data: response.data);
      }

      var curricula = await HiveService.get('curricula');
      return curricula[0];

      // Response response = await UrlService.get('curricula');
      // return response.data;
    } catch (e) {
      print(e);
      return false;
    }
  }

  int coursesPerSemester(Map courses) {
    int semester = courses['semester'];

    return semester;
  }

  Map<String, List<List>> coursesPerYear(Map programs) {
    List programInfo = programs['semester__course'];
    List courses = programs['courses_curriculums'];

    Map<String, List<List>> program = {};

    /*
    the first three index of the array is refers to the three Semester
    and the last index refers to information of the year
    */
    List<List> firstYear = [[], [], [], []];
    List<List> secondYear = [[], [], [], []];
    List<List> thirdYear = [[], [], [], []];
    List<List> fourthYear = [[], [], [], []];
    List<List> fifthYear = [[], [], [], []];

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

    List infosYear1 = [[], []];
    List infosYear2 = [[], []];
    List infosYear3 = [[], []];
    List infosYear4 = [[], []];
    List infosYear5 = [[], []];

    for (var i = 0; i < programInfo.length; i++) {
      if (programInfo[i]['year'] == 1) {
        if (programInfo[i]["semester"] == 1) {
          infosYear1[0].insert(0, programInfo[i]["number_of_elective"]);
          infosYear1[0].insert(1, programInfo[i]["number_of_free_elective"]);
        } else {
          infosYear1[1].insert(0, programInfo[i]["number_of_elective"]);
          infosYear1[1].insert(1, programInfo[i]["number_of_free_elective"]);
        }
      }

      if (programInfo[i]['year'] == 2) {
        if (programInfo[i]["semester"] == 1) {
          infosYear2[0].insert(0, programInfo[i]["number_of_elective"]);
          infosYear2[0].insert(1, programInfo[i]["number_of_free_elective"]);
        } else {
          infosYear2[1].insert(0, programInfo[i]["number_of_elective"]);
          infosYear2[1].insert(1, programInfo[i]["number_of_free_elective"]);
        }
      }

      if (programInfo[i]['year'] == 3) {
        if (programInfo[i]["semester"] == 1) {
          infosYear3[0].insert(0, programInfo[i]["number_of_elective"]);
          infosYear3[0].insert(1, programInfo[i]["number_of_free_elective"]);
        } else {
          infosYear3[1].insert(0, programInfo[i]["number_of_elective"]);
          infosYear3[1].insert(1, programInfo[i]["number_of_free_elective"]);
        }
      }

      if (programInfo[i]['year'] == 4) {
        if (programInfo[i]["semester"] == 1) {
          infosYear4[0].insert(0, programInfo[i]["number_of_elective"]);
          infosYear4[0].insert(1, programInfo[i]["number_of_free_elective"]);
        } else {
          infosYear4[1].insert(0, programInfo[i]["number_of_elective"]);
          infosYear4[1].insert(1, programInfo[i]["number_of_free_elective"]);
        }
      }

      if (programInfo[i]['year'] == 5) {
        if (programInfo[i]["semester"] == 1) {
          infosYear5[0].insert(0, programInfo[i]["number_of_elective"]);
          infosYear5[0].insert(1, programInfo[i]["number_of_free_elective"]);
        } else {
          infosYear5[1].insert(0, programInfo[i]["number_of_elective"]);
          infosYear5[1].insert(1, programInfo[i]["number_of_free_elective"]);
        }
      }
    }

    firstYear.insert(3, infosYear1);
    secondYear.insert(3, infosYear2);
    thirdYear.insert(3, infosYear3);
    fourthYear.insert(3, infosYear4);
    fifthYear.insert(3, infosYear5);

    // print(infosYear4);
    // print(thirdYear[2]);
    // print('-------');
    print(secondYear[3]);
    program['firstYear'] = firstYear;
    program['secondYear'] = secondYear;
    program['thirdYear'] = thirdYear;
    program['fourthYear'] = fourthYear;
    program['fifthYear'] = fifthYear;
    // print(program);
    return program;
  }
}

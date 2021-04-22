import 'package:astu_guide/apps/Courses/Detail.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/material.dart';

class ProgramCurriculumBody extends StatelessWidget {
  Map<String, List<List>> programCourses;

  ProgramCurriculumBody({this.programCourses});

  @override
  Widget build(BuildContext context) {
    // print(programCourses);
    return ListView.builder(
      itemCount: programCourses.length,
      itemBuilder: (context, index) {
        List year = [];
        print(index);
        switch (index) {
          case 0:
            year = ["firstYear", "1st Year"];
            break;
          case 1:
            year = ["secondYear", '2nd Year'];
            break;
          case 2:
            year = ["thirdYear", '3rd Year'];
            break;
          case 3:
            year = ["fourthYear", '4th Year'];
            break;
          case 4:
            year = ["fifthYear", "5th Year"];
            break;
        }

        print(year[0]);
        if (programCourses[year[0]] == null) {
          return Text("");
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  height: 25.0,
                  color: ASTUGuideTheme.primaryColor,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          year[1],
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "1st Semester",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: ASTUGuideTheme.teritiaryColor,
                height: 20.0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Code',
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Title',
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Cr-hour',
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: displayCourses(context, programCourses[year[0]], 0),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 2,
              //       child: Text(
              //         '${item['course']['code']}',
              //         style: TextStyle(fontSize: 14.5),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 5,
              //       child: Text(
              //         '${item['course']['title']}',
              //         style: TextStyle(fontSize: 14.5),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 2,
              //       child: Text(
              //         '${item['course']['credit_hour']}',
              //         style: TextStyle(fontSize: 14.5),
              //       ),
              //     ),
              //   ],
              // ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  height: 30.0,
                  color: ASTUGuideTheme.primaryColor,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(year[1],
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text("2nd Semester",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 25.0,
                color: ASTUGuideTheme.teritiaryColor,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Code',
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Title',
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Cr-hour',
                        style: TextStyle(fontSize: 17.5),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: displayCourses(context, programCourses[year[0]], 1),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> displayCourses(context, List item, int semester) {
    print(item[3]);
    List<Widget> listTile = [];
    for (var course in item[semester]) {
      bool isElective = course['is_elective'] == 1 ? true : false;
      if (isElective) continue;
      listTile.add(ListTile(
        onTap: () {
          // print(item);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailCourses(
                        course: course['course'],
                      )));
        },
        trailing: Text(
          '${course['course']['credit_hour']}',
          style: TextStyle(fontSize: 14.5),
        ),
        leading: Text(
          '${course['course']['code']}',
          style: TextStyle(fontSize: 14.5),
        ),
        title: Text(
          '${course['course']['title']}',
          style: TextStyle(fontSize: 14.5),
        ),
      ));
    } // first for loop
    if (!item[3][semester].isEmpty) {
      for (var i = 0; i < item[3][semester][0]; i++) {
        listTile.add(ListTile(
          onTap: () {
            List electiveCourses = separateElectiveCourse(item[semester]);
            showModalBottomSheet(
                context: context,
                builder: (BuildContext bc) {
                  return SingleChildScrollView(
                    child: Column(
                      children: electiveCourses.map((electiveCourse) {
                        return ListTile(
                          onTap: () {},
                          trailing: Text(
                            "${electiveCourse['course']['credit_hour']}",
                            style: TextStyle(fontSize: 14.5),
                          ),
                          leading: Text(
                            "${electiveCourse['course']['code']}",
                            style: TextStyle(fontSize: 14.5),
                          ),
                          title: Text(
                            '${electiveCourse['course']['title']}',
                            style: TextStyle(fontSize: 14.5),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                });
            print(electiveCourses);
          },
          trailing: Text(
            '-',
            style: TextStyle(fontSize: 14.5),
          ),
          leading: Text(
            '-',
            style: TextStyle(fontSize: 14.5),
          ),
          title: Text(
            'Elective Course',
            style: TextStyle(fontSize: 14.5),
          ),
        ));
      }
      for (var i = 0; i < item[3][semester][1]; i++) {
        listTile.add(ListTile(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'You can select any course from the compus',
                  style: TextStyle(color: Colors.redAccent),
                ),
                duration: Duration(seconds: 10),
              ),
            );
          },
          trailing: Text(
            '-',
            style: TextStyle(fontSize: 14.5),
          ),
          leading: Text(
            '-',
            style: TextStyle(fontSize: 14.5),
          ),
          title: Text(
            'Free elective course',
            style: TextStyle(fontSize: 14.5),
          ),
        ));
      }
    }

    return listTile;
  }

  List separateElectiveCourse(List courses) {
    var filteredCourse = courses.where((element) {
      return element['is_elective'] == 1 ? true : false;
    });
    return filteredCourse.toList();
  }
}

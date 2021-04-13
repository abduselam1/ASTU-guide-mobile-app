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
              Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: Container(
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
              ),
              for (var item in programCourses[year[0]][0])
                ListTile(
                  onTap: () {},
                  trailing: Text(
                    '${item['course']['credit_hour']}',
                    style: TextStyle(fontSize: 14.5),
                  ),
                  leading: Text(
                    '${item['course']['code']}',
                    style: TextStyle(fontSize: 14.5),
                  ),
                  title: Text(
                    '${item['course']['title']}',
                    style: TextStyle(fontSize: 14.5),
                  ),
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
                  height: 25.0,
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
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Container(
                  height: 20.0,
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
              ),
              for (var item in programCourses[year[0]][1])
                ListTile(
                  onTap: () {
                    // print(item);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailCourses(
                                  course: item['course'],
                                )));
                  },
                  trailing: Text(
                    '${item['course']['credit_hour']}',
                    style: TextStyle(fontSize: 14.5),
                  ),
                  leading: Text(
                    '${item['course']['code']}',
                    style: TextStyle(fontSize: 14.5),
                  ),
                  title: Text(
                    '${item['course']['title']}',
                    style: TextStyle(fontSize: 14.5),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

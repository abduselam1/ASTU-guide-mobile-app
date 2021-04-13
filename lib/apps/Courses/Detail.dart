import 'package:astu_guide/apps/Courses/partials/CourceResource.dart';
import 'package:astu_guide/apps/Courses/partials/CourseDetailBody.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/material.dart';

class DetailCourses extends StatefulWidget {
  Map course;
  DetailCourses({this.course});

  @override
  _DetailCoursesState createState() => _DetailCoursesState(course: course);
}

class _DetailCoursesState extends State<DetailCourses> {
  Map course;
  int _currendIndex = 0;
  _DetailCoursesState({this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${course['title']}"),
        centerTitle: true,
      ),
      body: _currendIndex == 1
          ? CourseResource(
              courseMaterials: course,
            )
          : CourseDetailBody(
              courses: course,
            ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey[700],
        type: BottomNavigationBarType.shifting,
        currentIndex: _currendIndex,
        onTap: (index) {
          setState(() {
            _currendIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              // label: "",
              label: "Information",
              backgroundColor: ASTUGuideTheme.secondaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: "Resources",
              backgroundColor: ASTUGuideTheme.secondaryColor),
        ],
      ),
    );
  }
}

// import 'dart:js';

import 'package:astu_guide/apps/Controller/CourseController.dart';

import 'package:flutter/material.dart';

class CourseBody extends StatelessWidget {
  var courses;
  CourseBody({this.courses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return CourseController.buildList(courses[index], context);
      },
    );
  }
}

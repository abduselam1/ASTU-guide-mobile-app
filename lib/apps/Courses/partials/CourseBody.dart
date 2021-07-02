// import 'dart:js';

import 'package:astu_guide/apps/Controller/CourseController.dart';

import 'package:flutter/material.dart';

class CourseBody extends StatefulWidget {
  final courses;
  CourseBody({this.courses});

  @override
  _CourseBodyState createState() => _CourseBodyState();
}

class _CourseBodyState extends State<CourseBody> {
  int updated = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (await CourseController.updateCourse() == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No internet Connection please try again'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Content successfuly updated'),
            ),
          );
          setState(() {
            updated = 1;
          });
        }
      },
      child: ListView.builder(
        itemCount: widget.courses.length,
        itemBuilder: (context, index) {
          return CourseController.buildList(widget.courses[index], context);
        },
      ),
    );
  }
}

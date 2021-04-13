import 'package:astu_guide/apps/Controller/CourseController.dart';
import 'package:astu_guide/apps/Courses/partials/CourseBody.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:flutter/material.dart';

class CourseView extends StatefulWidget {
  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  String searchKeyWord = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ASTUGuideTheme.teritiaryColor,
      appBar: AppBar(
        title: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search for Courses",
              // focusColor: ASTUGuideTheme.textFadedColor1
            ),
            onChanged: (value) {
              setState(() {
                searchKeyWord = value;
              });
            }),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: CourseController.courses(searchKeyWord: searchKeyWord),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || snapshot.data == false) {
              return NetworkError();
            }
            return CourseBody(courses: snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

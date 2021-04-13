// import 'dart:js';

import 'package:astu_guide/apps/Courses/partials/ResourceBody.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseResource extends StatelessWidget {
  Map courseMaterials;

  CourseResource({this.courseMaterials});

  showDescription() {
    // CupertinoAlertDialog(
    //   content: Center(
    //       child: Text("somethign"),
    //   ),
    //   actions: [
    //     CupertinoDialogAction(
    //       child: Text("cancel"),
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //     )
    //   ],
    // );
  }

  Future courseMaterial() async {
    return courseMaterials;
    // try {
    //   Response response = await UrlService.get('course-material/$id');
    //   return response.data;
    // } catch (e) {
    //   print(e);
    //   return false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: courseMaterial(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return NetworkError();
            }
            if (snapshot.data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_empty, size: 50.0),
                    Text("There is no Resource available for this Course")
                  ],
                ),
              );
            }
            // print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data['course_materials'].length,
              itemBuilder: (context, index) {
                return ResourceBody(
                    resources: snapshot.data['course_materials'][index],
                    title: snapshot.data['title']);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

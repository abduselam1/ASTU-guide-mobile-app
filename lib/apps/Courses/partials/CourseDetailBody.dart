import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CourseDetailBody extends StatelessWidget {
  Map courses;

  Future getPreRequest(id) async {
    if (id == null) {
      return null;
    }
    try {
      Response response = await UrlService.get('course/$id');
      return response.data;
    } catch (e) {
      return false;
    }
  }

  CourseDetailBody({this.courses});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Center(
                child: Text(
                  "Detail information",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: RichText(
                text: TextSpan(
                    text: "Course Name: ${courses['title']}",
                    style: TextStyle(color: Colors.black)),
                overflow: TextOverflow.visible,
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: RichText(
                text: TextSpan(
                    text: "Course code: ${courses['code']}",
                    style: TextStyle(color: Colors.black)),
                overflow: TextOverflow.visible,
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: FutureBuilder(
                future: getPreRequest(courses['prerequisites']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == false && snapshot.hasError) {
                      return Center(
                        child: Text("Pre-request: ..."),
                      );
                    }
                    return RichText(
                      text: TextSpan(
                          text: snapshot.data == null
                              ? 'Pre-request: none'
                              : "Pre-request: ${snapshot.data['title']}",
                          style: TextStyle(color: Colors.black)),
                      overflow: TextOverflow.visible,
                    );
                  } else {
                    return Text("Pre-request: ...");
                  }
                },
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: RichText(
                text: TextSpan(
                    text: "Credit hour: ${courses['credit_hour']}",
                    style: TextStyle(color: Colors.black)),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

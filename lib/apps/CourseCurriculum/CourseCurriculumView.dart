import 'package:astu_guide/apps/Controller/CourseCurriculumController.dart';
import 'package:astu_guide/apps/CourseCurriculum/partials/CourseCurriculumBody.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:flutter/material.dart';

class CourseCurriculumView extends StatefulWidget {
  @override
  _CourseCurriculumViewState createState() => _CourseCurriculumViewState();
}

class _CourseCurriculumViewState extends State<CourseCurriculumView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Programs"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: CourseCurriculumController().curriculum(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return Center(
                child: NetworkError(),
              );
            }
            if (snapshot.data.length == 0) {
              return Center(
                child: Text("There is no Curriculum in the ASTU right now"),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
              },
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return CourseCurriculumBody(
                    programs: snapshot.data[index],
                  );
                },
              ),
            );
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

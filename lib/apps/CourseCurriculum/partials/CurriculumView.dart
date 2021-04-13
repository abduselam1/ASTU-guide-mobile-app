// import 'dart:js';

import 'package:astu_guide/apps/Controller/CourseCurriculumController.dart';
import 'package:astu_guide/apps/CourseCurriculum/partials/ProgramCurriculumBody.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CurriculumView extends StatefulWidget {
  Map program;
  CurriculumView({this.program});

  @override
  _CurriculumViewState createState() => _CurriculumViewState(program: program);
}

class _CurriculumViewState extends State<CurriculumView> {
  Map program;
  _CurriculumViewState({this.program});

  Future courseProgram() async {
    return program;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${program['program_name']}"),
          centerTitle: true,
        ),
        body: ProgramCurriculumBody(
          programCourses: CourseCurriculumController().coursesPerYear(program['courses_curriculums']),
        ));
  }
}

import 'package:astu_guide/apps/CourseCurriculum/partials/CurriculumView.dart';
import 'package:flutter/material.dart';

class CourseCurriculumBody extends StatelessWidget {
  Map programs;
  CourseCurriculumBody({this.programs});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: ListTile(
        title: Text("${programs['program_name']}"),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios_outlined),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurriculumView(
                          program: programs,
                        )));
          },
        ),
      ),
    );
  }
}

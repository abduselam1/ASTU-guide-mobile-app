// import 'package:astu_guide/apps/CourseCuricullum/CourseCuricullum.dart';
import 'package:astu_guide/apps/CourseCurriculum/CourseCurriculumView.dart';
import 'package:astu_guide/apps/Courses/CoursesView.dart';
import 'package:astu_guide/apps/Information/views/index.dart';
import 'package:astu_guide/apps/LostID/LostIdShow.dart';
import 'package:astu_guide/apps/event/Event.dart';
import 'package:astu_guide/apps/map/BuildingView.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:astu_guide/common/views/partials/choice_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astu_guide/apps/Rules/index.dart';

class DashboardChoice extends StatefulWidget {
  @override
  _DashboardChoiceState createState() => _DashboardChoiceState();
}

class _DashboardChoiceState extends State<DashboardChoice> {
  Uri shareLink;

  createDynamicLinkForPharmacy() async {
    // await CreateDynamicLink()
    //     .create(FirebaseAuth.instance.currentUser.phoneNumber, short: true)
    //     .then((value) => setState(() => shareLink = value));
  }

  Future<void> share() async {
    // await FlutterShare.share(
    //   title: 'Medlo',
    //   text: 'Medlo Pharmacy App',
    //   linkUrl: shareLink.toString(),
    //   chooserTitle: 'Open Pharmacy Detail',
    // );
  }

  @override
  void initState() {
    createDynamicLinkForPharmacy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.only(top: size.height * 0.04, left: 10.0, right: 10.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(237, 246, 255, 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ChoiceIcon(
                title: 'Curriculum',
                icon: Icons.call_split,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CourseCurriculumView()));
                },
                color: Colors.amber,
              ),
              ChoiceIcon(
                title: 'Courses',
                icon: Icons.layers,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CourseView()));
                },
                color: Colors.pinkAccent,
              ),
              ChoiceIcon(
                title: 'Materials',
                icon: Icons.library_books,
                onTap: () {},
                color: ASTUGuideTheme.primaryColor,
              ),
              ChoiceIcon(
                title: 'Map',
                icon: Icons.location_on,
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BuildingView()));
                },
                color: Color.fromRGBO(32, 187, 45, 1),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ChoiceIcon(
                title: 'Calendar',
                icon: Icons.calendar_today,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Event()));
                },
                color: Colors.blueAccent,
              ),
              ChoiceIcon(
                title: 'Information',
                icon: Icons.info,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Information()));
                },
                color: Colors.indigo,
              ),
              ChoiceIcon(
                title: 'Lost ID',
                icon: Icons.payment,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LostIdShow()));
                },
                color: Colors.blueGrey,
              ),
              ChoiceIcon(
                title: 'Rules',
                icon: Icons.rule,
                onTap: () async {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Rule()));
                },
                color: Colors.cyan,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

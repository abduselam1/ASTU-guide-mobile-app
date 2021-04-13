import 'package:astu_guide/apps/Information/partials/InformationChoice.dart';
import 'package:astu_guide/apps/Information/views/AmbulanceView.dart';
import 'package:astu_guide/apps/Information/views/OfficeView.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text("Informations"),
          centerTitle: true,
        ),
        body: CustomScrollView(
            // color: Color.fromRGBO(237, 246, 255, 1 ),
            // padding: EdgeInsets.all(8.0),
            // col
            // decoration: BoxDecoration(
            //   color: Colors.blue[100],
            //   borderRadius: BorderRadius.circular(10.0),
            // ),
            physics: ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/img/info1.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InformationChoice(
                            title: 'Office',
                            icon: Icons.circle,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OfficeView()));
                            },
                            color: Colors.amber,
                          ),
                          InformationChoice(
                            title: 'Ambulance',
                            icon: Icons.local_hospital_outlined,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AmbulanceView()));
                            },
                            color: Colors.pinkAccent,
                          ),
                          InformationChoice(
                            title: 'Department',
                            icon: Icons.school_outlined,
                            onTap: () {},
                            color: Colors.teal,
                          ),
                          InformationChoice(
                            title: 'Managers',
                            icon: Icons.person_search_sharp,
                            onTap: () {},
                            color: Colors.lime,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]));
  }
}

import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardHero extends StatefulWidget {
  @override
  _DashboardHeroState createState() => _DashboardHeroState();
}

class _DashboardHeroState extends State<DashboardHero> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: ASTUGuideTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.27,
              )
            ],
          ),
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: size.width,
                    margin: EdgeInsets.only(
                        top: 100.0, left: 30.0, bottom: 30.0, right: 30.0),
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .5),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: size.height * 0.2,
                          child: Image.asset(
                              "assets/img/student_looking_mobile.png"),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          transform: Matrix4.rotationZ(0.2),
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Icon(
                                      Icons.schedule,
                                      color: Colors.white,
                                      size: 40.0,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'My Schedule',
                                    style: TextStyle(
                                      color: Color.fromRGBO(150, 150, 150, 1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.35, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(''),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ASTUGuideTheme.secondaryColor,
                      ),
                      child: FlatButton.icon(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        onPressed: () {},
                        color: ASTUGuideTheme.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        icon: const Icon(
                          Icons.person_search,
                          color: Colors.white,
                        ),
                        label: Text(
                          'My Curriculum',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

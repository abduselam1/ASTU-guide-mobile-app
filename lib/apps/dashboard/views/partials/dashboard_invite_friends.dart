import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardInviteFriends extends StatefulWidget {
  @override
  _DashboardInviteFriendsState createState() => _DashboardInviteFriendsState();
}

class _DashboardInviteFriendsState extends State<DashboardInviteFriends> {
  Future<void> share() async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: size.width,
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: size.height * 0.2,
                child: Image.asset("assets/img/student_looking_mobile.png"),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50.0),
                transform: Matrix4.rotationZ(0.3),
                child: FlatButton.icon(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  onPressed: share,
                  color: ASTUGuideTheme.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  icon: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Invite Friends',
                  ),
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

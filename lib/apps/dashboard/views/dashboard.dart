import 'dart:convert';

import 'package:astu_guide/apps/auth/models/user_model.dart';
import 'package:astu_guide/apps/dashboard/views/partials/custom_app_bar.dart';
import 'package:astu_guide/apps/dashboard/views/partials/custom_app_drawer.dart';
import 'package:astu_guide/apps/dashboard/views/partials/dashboard_choice.dart';
import 'package:astu_guide/apps/dashboard/views/partials/dashboard_hero.dart';
import 'package:astu_guide/apps/dashboard/views/partials/dashboard_invite_friends.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Future getUser() async {
    try {
      Box box = await Hive.openBox('auth');
      return box.get('user');
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel user =
              UserModel.fromJson(jsonDecode(jsonEncode(snapshot.data)));
          return SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(75.0),
                child: CustomAppBar(user: user),
              ),
              drawer: CustomAppDrawer(user: user),
              body: CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        DashboardHero(),
                        DashboardChoice(),
                        DashboardInviteFriends()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          color: Colors.white,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

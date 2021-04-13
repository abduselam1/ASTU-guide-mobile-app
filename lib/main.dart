import 'dart:io';

import 'package:astu_guide/apps/auth/views/login_view.dart';
import 'package:astu_guide/apps/dashboard/views/dashboard.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await setupHive();

  runApp(ASTUGuideApp());
}

Future setupHive() async {
  try {
    await Hive.initFlutter();
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  } catch (e) {}
}

Future isLoggedIn() async {
  try {
    Box box = await Hive.openBox('auth');
    return box.get('token') == null ? false : true;
  } catch (e) {
    return null;
  }
}

class ASTUGuideApp extends StatefulWidget {
  @override
  _ASTUGuideAppState createState() => _ASTUGuideAppState();
}

class _ASTUGuideAppState extends State<ASTUGuideApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          // return LoginView();
          if (snapshot.hasData) {
            if (snapshot.data) {
              return DashboardView();
            } else {
              return LoginView();
            }
          }
          return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
      theme: ThemeData.light().copyWith(
        primaryColor: ASTUGuideTheme.primaryColor,
        accentColor: ASTUGuideTheme.secondaryColor,
      ),
    );
  }
}

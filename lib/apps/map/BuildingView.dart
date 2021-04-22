import 'dart:async';

import 'package:astu_guide/apps/Controller/BuildingController.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:astu_guide/apps/map/partials/BuildingBody.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:astu_guide/common/services/Connection.dart';
import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class BuildingView extends StatefulWidget {
  @override
  _BuildingViewState createState() => _BuildingViewState();
}

class _BuildingViewState extends State<BuildingView> {
  int updated = 1;
  String searchKeyWord = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search for buildings",
                fillColor: ASTUGuideTheme.textFadedColor1),
            onChanged: (value) {
              setState(() {
                searchKeyWord = value;
              });
            }),
      ),
      body: FutureBuilder(
        future:
            BuildingController.searchForBuildings(searchKeyWord: searchKeyWord),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _showSnackBar(context);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return NetworkError();
            }
            return RefreshIndicator(
              onRefresh: () async {
                if (await BuildingController.updateCourse() == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No internet Connection please try again'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Content successfuly updated'),
                    ),
                  );
                  setState(() {
                    updated = 1;
                  });
                }
              },
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return BuildingBody(building: snapshot.data[index]);
                  }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  dynamic _showSnackBar(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('error occured please try again!'),
      ),
    );
  }
}

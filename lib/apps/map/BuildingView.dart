import 'dart:async';

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
  String searchKeyWord = '';

  Future searchForBuildings({String value = ''}) async {
    var cacheBuilding = await HiveService.get('building');
    if (cacheBuilding == false) {
      if (await Connection().isConnected()) {
        try {
          Response response = await UrlService.get('buildings');
          // print(response.data);
          await HiveService.put(boxName: 'building', data: response.data);
        } catch (e) {
          print(e);
          return false;
        }
      } else {
        return false;
      }
    }

    var building = await HiveService.get('building');
    print(building[0]);
    var filter = building[0].where((element) {
      String keyWord = searchKeyWord.trim();
      String building_number = element['building_number'].toString();
      if (building_number.contains(RegExp(keyWord)) ||
          element['building_name'].contains(RegExp(keyWord)) ||
          element['description'].contains(RegExp(keyWord))) {
        return true;
      }
      return false;
    });

    return filter.toList();
  }

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
        future: searchForBuildings(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _showSnackBar(context);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return NetworkError();
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return BuildingBody(building: snapshot.data[index]);
                });
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

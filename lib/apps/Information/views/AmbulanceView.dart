import 'package:astu_guide/apps/Controller/EssentialInformationController.dart';
import 'package:astu_guide/apps/Information/partials/DriverList.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:astu_guide/common/services/Connection.dart';
import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AmbulanceView extends StatefulWidget {
  @override
  _AmbulanceViewState createState() => _AmbulanceViewState();
}

class _AmbulanceViewState extends State<AmbulanceView> {
  String searchKeyWord = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search for Ambulance drivers",
              // focusColor: ASTUGuideTheme.textFadedColor1
            ),
            onChanged: (value) {
              setState(() {
                searchKeyWord = value;
              });
            }),
        // title: Text(
        //   "Search for Ambulance drivers",
        //   style: TextStyle(
        //     color: Colors.white54,
        //   ),

        // ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: EssentialInformationController.ambulanceDrivers(searchKeyWord),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false || snapshot.hasError) {
              return NetworkError();
            } else {
              var data = snapshot.data;
              return DriverList(
                data: data,
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

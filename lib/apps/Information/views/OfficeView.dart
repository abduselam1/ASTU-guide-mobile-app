import 'package:astu_guide/apps/Controller/EssentialInformationController.dart';
import 'package:astu_guide/apps/Information/partials/OfficeList.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:astu_guide/common/services/Connection.dart';
import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OfficeView extends StatefulWidget {
  @override
  _OfficeViewState createState() => _OfficeViewState();
}

class _OfficeViewState extends State<OfficeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Office Information"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: EssentialInformationController().getOfficeInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something gone wrong try again"),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return Center(
                child: NetworkError(),
              );
            }

            return OfficeList(officelist: snapshot.data);
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

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common/services/url_service.dart';

class BuildingMap extends StatefulWidget {
  var data;
  BuildingMap({this.data});
  @override
  _BuildingMapState createState() => _BuildingMapState(data: data);
}

class _BuildingMapState extends State<BuildingMap> {
  var data;
  _BuildingMapState({this.data});
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> marker = [];

  int blockNumber;
  String name;
  String desc;
  // Widget _mapTaped(LatLng latlng) {
  //   r
  // }

  void initState() {
    super.initState();
    print(data);
    print('------');
    setState(() {
      marker.add(Marker(
          markerId: MarkerId(data['building_name']),
          position: LatLng(data['latitude'], data['longitude']),
          infoWindow: InfoWindow(title: "${data['building_number']}")));
    });
  }

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(data['latitude'], data['longitude']),
  //   zoom: 14.4746,
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buildings"),
        centerTitle: true,
      ),
      body: GoogleMap(
        
        // onTap: (LatLng latlng) {
        //   _mapTaped(latlng);
        // },
        mapType: MapType.hybrid,
        markers: Set.from(marker),
        initialCameraPosition: CameraPosition(
          target: LatLng(data['latitude'], data['longitude']),
          zoom: 17.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

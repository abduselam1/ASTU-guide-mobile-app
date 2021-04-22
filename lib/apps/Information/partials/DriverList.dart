import 'package:astu_guide/apps/Controller/EssentialInformationController.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverList extends StatefulWidget {
  final data;
  DriverList({this.data});

  @override
  _DriverListState createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  int updated = 1;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (await EssentialInformationController.updateDrivers() == false) {
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
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return listOfDrivers(context, widget.data[index]);
        },
      ),
    );
  }

  Widget listOfDrivers(context, drivers) {
    return Card(
      margin: EdgeInsets.all(0.0),
      shadowColor: Colors.transparent,
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(drivers['driver_name']),
        trailing: IconButton(
          icon: Icon(Icons.call),
          onPressed: () async {
            try {
              await launch("tel://${drivers['phone_number']}");
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Can\'t call now!'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

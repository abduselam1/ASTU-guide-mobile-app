import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverList extends StatelessWidget {
  final data;
  DriverList({this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        print(data);
        return listOfDrivers(context, data[index]);
      },
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
              print(drivers['phone_number']);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Cant call now!'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

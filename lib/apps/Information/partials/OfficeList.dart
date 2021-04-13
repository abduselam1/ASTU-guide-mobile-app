import 'package:astu_guide/apps/map/partials/map.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficeList extends StatelessWidget {
  var officelist;

  OfficeList({this.officelist});

  Widget cardForOffice(offices, context) {
    return Card(
      shadowColor: Colors.transparent,
      child: ListTile(
        leading: Icon(Icons.home_filled),
        title: Text("${offices['office_title']}"),
        subtitle: Text(
            "Currently in control of ${offices['office_holder_person_name']}"),
        trailing: Column(
          children: [
            Expanded(
              child: IconButton(
                  icon: Icon(
                    Icons.call,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    await launch("tel://${offices['phone_number']}");
                  }),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.map_outlined,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuildingMap(
                                data: offices['building'],
                              )));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
        return null;
      },
      child: ListView.builder(
        itemCount: officelist.length,
        itemBuilder: (context, index) {
          return cardForOffice(officelist[index], context);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EventBody extends StatelessWidget {
  var event;
  EventBody({this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      // shadowColor: Colors.transparent,
      color: Colors.white,
      child: ExpansionTile(
        leading: Icon(Icons.event_outlined),
        title: Text(
          "${event['title']}",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text("Event held at ${event['date']}"),
        children: [Text("${event['description']}")],
      ),
    );
  }
}

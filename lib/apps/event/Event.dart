import 'package:astu_guide/apps/Controller/EventController.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:astu_guide/apps/event/partials/EventBody.dart';
import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {

  int updated=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Acadamic calender"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: EventController().fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return NetworkError();
            }

            return RefreshIndicator(
              onRefresh: () async {
                if (await EventController.updateCourse() == false) {
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
                  return EventBody(
                    event: snapshot.data[index],
                  );
                },
              ),
            );
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

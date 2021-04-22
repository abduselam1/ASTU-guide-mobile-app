// import 'dart:js';

import 'package:astu_guide/apps/Controller/LostIdController.dart';
import 'package:astu_guide/apps/LostID/partials/LostIdBody.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:flutter/material.dart';

class LostIdShow extends StatefulWidget {
  @override
  _LostIdShowState createState() => _LostIdShowState();
}

class _LostIdShowState extends State<LostIdShow> {
  List idd = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lost id"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: LostIdController.showLostIds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return NetworkError();
            }
            if (snapshot.data.isEmpty) {
              return Center(
                child: Text("Nothing found"),
              );
            }
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return LostIdBody(
                  lostId: snapshot.data[index],
                );
              },
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

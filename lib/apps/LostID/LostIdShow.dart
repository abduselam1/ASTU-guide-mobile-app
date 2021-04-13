import 'package:flutter/material.dart';

class LostIdShow extends StatefulWidget {
  @override
  _LostIdShowState createState() => _LostIdShowState();
}

class _LostIdShowState extends State<LostIdShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lost id"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('asdf'),
        ),
      ),
    );
  }
}

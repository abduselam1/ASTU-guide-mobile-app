import 'package:flutter/material.dart';

class ChoiceIcon extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final Color color;
  final String title;

  const ChoiceIcon({
    Key key,
    @required this.icon,
    @required this.onTap,
    @required this.color,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(color: Color.fromRGBO(150, 150, 150, 1)),
            )
          ],
        ),
      ),
    );
  }
}

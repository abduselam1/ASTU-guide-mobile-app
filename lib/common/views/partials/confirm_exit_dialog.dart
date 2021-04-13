import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmExitDialog extends StatefulWidget {
  @override
  _ConfirmExitDialogState createState() => _ConfirmExitDialogState();
}

class _ConfirmExitDialogState extends State<ConfirmExitDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: new Text(
        'Are you sure?',
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Do you want to exit ASTU guied',
            ),
          ],
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('No'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Yes'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LostIdBody extends StatelessWidget {
  final Map lostId;

  LostIdBody({this.lostId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: lostId['item'] == "ATM card"
            ? Icon(Icons.account_balance_wallet)
            : Icon(Icons.payment),
        title: Text(
          "Found by ${lostId['name']}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${lostId['identifier']}"),
        trailing: IconButton(
          icon: Icon(Icons.call),
          onPressed: () async {
            try {
              await launch("tel://${lostId['contact_number']}");
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

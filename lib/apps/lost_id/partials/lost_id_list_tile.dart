import 'package:astu_guide/apps/lost_id/models/lost_id_model.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LostIdListTile extends StatelessWidget {
  final LostIdModel lostId;

  LostIdListTile({this.lostId});

  Widget cutomIcon(IconData icon, Color color, double radius) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  Widget itemIcon(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(12, 12, 12, 0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        icon,
        color: color,
        size: 35,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(143, 148, 251, .3),
            blurRadius: 2,
          )
        ],
      ),
      child: ListTile(
        leading: lostId.item == "ATM card"
            ? itemIcon(
                Icons.account_balance_wallet,
                Color.fromRGBO(32, 187, 45, 1),
              )
            : itemIcon(Icons.payment, Colors.deepOrangeAccent),
        title: Text(
          lostId.name,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Text(
            lostId.identifier,
            style: TextStyle(color: Colors.black38),
          ),
        ),
        trailing: InkWell(
          onTap: () async {
            try {
              await launch("tel://${lostId.phoneNumber}");
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Can\'t call now!'),
                ),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.call, color: Color.fromRGBO(12, 12, 12, 0.5)),
              Text(
                "${lostId.createdAt}",
                style: TextStyle(color: Colors.black38),
              )
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            "No internet Connection"
          )
        ],
      ),
    );
  }
}
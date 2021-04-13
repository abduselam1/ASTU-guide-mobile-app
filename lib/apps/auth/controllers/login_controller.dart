import 'package:astu_guide/apps/auth/views/login_view.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LoginController {
  static Future<bool> login({email, password}) async {
    try {
      final Response response = await UrlService.post(url: 'auth/login', data: {
        'email': email,
        'password': password,
        'device_name': 'Pixel 2',
      });

      UrlService.setToken(response);

      Box box = await Hive.openBox('auth');

      box.put('user', response.data['user']);
      box.put('token', response.data['token']);

      return true;
    } on DioError catch (e) {
      print(e);
      return false;
    }
  }

  static Future logout(BuildContext context, {needConfirmation: false}) async {
    bool logout = true;
    try {
      if (needConfirmation) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: new Text(
                'Log out',
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'Are you sure you want to log out?',
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () {
                    logout = false;
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(
                    'Log out',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      }

      if (logout) {
        Box box = await Hive.openBox('auth');
        box.delete('user');
        box.delete('token');

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginView(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginView(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }
}

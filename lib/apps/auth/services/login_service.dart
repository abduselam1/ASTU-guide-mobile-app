import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class LoginService {
  static Future setLoggedIn(Response response) async {
    UrlService.setToken(response);

    Box box = await Hive.openBox('auth');
    box.put('user', response.data['user']);
    box.put('token', response.data['token']);
  }
}

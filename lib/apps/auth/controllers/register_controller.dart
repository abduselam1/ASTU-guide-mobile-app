import 'package:astu_guide/apps/auth/services/login_service.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class RegisterController {
  static Future<bool> register({
    name,
    phoneNumber,
    email,
    password,
    astuId,
    school,
    department,
    year,
    section,
  }) async {
    try {
      final Response response =
          await UrlService.post(url: 'auth/register', data: {
        'name': name,
        'phone_number': phoneNumber,
        'email': email,
        'password': password,
        'astu_id': astuId,
        'school': school,
        'department': department,
        'year': year,
        'section': section,
        'device_name': 'Pixel 2',
      });

      LoginService.setLoggedIn(response);

      return true;
    } on DioError catch (e) {
      print(e.response.data);
      return false;
    }
  }

  static Future<List<String>> programs() async {
    try {
      final Response response = await UrlService.get('auth/curricula/prepared');
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response.data);
      return null;
    }
  }
}

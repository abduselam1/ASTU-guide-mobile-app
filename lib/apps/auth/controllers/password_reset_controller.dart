import 'package:astu_guide/apps/auth/services/login_service.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class PasswordResetController {
  static Future<bool> reset({email, code, newPassword}) async {
    try {
      final Response response = await UrlService.post(
        url: 'auth/reset-password',
        data: {
          'email': email,
          'code': code,
          'password': newPassword,
          'device_name': 'Pixel 2'
        },
      );

      LoginService.setLoggedIn(response);

      return true;
    } on DioError catch (e) {
      print(e.response.data);
      return false;
    }
  }
}

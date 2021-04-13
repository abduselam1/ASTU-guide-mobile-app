import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class ForgotPasswordController {
  static Future<bool> forgotPassword({email}) async {
    try {
      await UrlService.post(url: 'auth/forgot-password', data: {
        'email': email,
      });

      return true;
    } on DioError catch (e) {
      return false;
    }
  }
}

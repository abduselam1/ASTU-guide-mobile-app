import 'package:astu_guide/common/services/Connection.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class LostIdController {
  Future register(
      {String name, String id, String phoneNumber, String type}) async {
    Response response;
    try {
      response = await UrlService.post(url: 'lostid', data: {
        'name': name,
        'item': type,
        'contact_number': phoneNumber,
        'identifier': id
      });
      return response.data;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future showLostIds() async{
    if (await Connection().isConnected()) {
      try {
        Response response = await UrlService.get('lostid');
        return response.data;
      } catch (e) {
        return false;
      }
    }
    return false;
  }
}

import 'package:astu_guide/apps/lost_id/models/lost_id_model.dart';
import 'package:astu_guide/common/services/Connection.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';

class LostIdController {
  Future register(
      {String name, String identifier, String phoneNumber, String type}) async {
    Response response;
    try {
      response = await UrlService.post(url: 'lostid', data: {
        'name': name,
        'item': type,
        'phone_number': phoneNumber,
        'identifier': identifier
      });
      return response.data;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // List<Special> parseSpecials(String json) {
  //   List<dynamic> specials = jsonDecode(json)['spDish'];
  //   return specials.map((special) => Special.fromJson(special)).toList();
  // }

  // Future<List<Special>> specials(cafeId) async {
  //   final response = await UrlService.get('cafes/$cafeId');
  //   if (response.statusCode == 200) {
  //     return CafeService().parseSpecials(response.body);
  //   } else {
  //     throw Exception('Failed to load specials');
  //   }
  // }
  //
  // List<Menu> parseMenus(String json) {
  //   Map<String, dynamic> menusNotFormatted = jsonDecode(json);
  //   List<dynamic> menus = [];
  //   menusNotFormatted.forEach((key, value) => menus.addAll(value));
  //   return menus.map((menu) => Menu.fromJson(menu)).toList();
  // }

  Future<List<LostIdModel>> lostIds() async {
    if (await Connection().isConnected()) {
      // try {
      Response response = await UrlService.get('lostid');
      List<dynamic> lostIds = response.data;
      print(lostIds.map((lostId) => LostIdModel.fromJson(lostId)).toList());

      return lostIds.map((lostId) => LostIdModel.fromJson(lostId)).toList();

      // } catch (e) {

      return null;
      // }
    }
    return null;
  }
}

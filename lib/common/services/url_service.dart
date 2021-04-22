import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// 192.168.0.248
class UrlService {
  static final String baseUrl = 'http://192.168.8.107:4000';
  static final String apiEndPoint = "$baseUrl/api/v1/mobile";
  static final String assetUrl = "$baseUrl/storage";
  static Dio dio = new Dio();

  static Map<String, String> headers = {
    'content-type': 'application/json',
    'accept': 'application/json',
    'connection': 'keep-alive',
    'authorization': null
  };

  UrlService() {
    getToken();
  }

  static Future<Response> post({String url, Map<String, dynamic> data}) async {
    final response = await dio.post(
      "${UrlService.apiEndPoint}/$url",
      options: Options(headers: UrlService.headers),
      data: FormData.fromMap(data),
    );

    print(response.statusCode);
    return response;
  }

  static Future<Response> get(String url) async {
    final response = await dio.get(
      "${UrlService.apiEndPoint}/$url",
      options: Options(headers: UrlService.headers),
    );

    // print(response.data);
    return response;
  }

  static Future<Response> delete(String url) async {
    final response = await dio.delete(
      "${UrlService.apiEndPoint}/$url",
      options: Options(headers: UrlService.headers),
    );

    // UrlService.setCookie(response.headers);
    return response;
  }

  static setCookie(Headers headers) {
    // print(headers.map);
    // UrlService.headers['cookie'] = headers.map['set-cookie']?.split(";")[0];
  }

  static setToken(Response response) {
    UrlService.headers['authorization'] = "Bearer ${response.data['token']}";
  }

  static getToken() async {
    print('get token called');
    Box box = await Hive.openBox('auth');
    String token = box.get('token');

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      if (options.headers["authorization"] == null) {
        dio.lock();
        options.headers["authorization"] = "Bearer $token";
        dio.unlock();
      }
      return options;
    }));
  }

  static Future<bool> download(
      {String url, String fileName, String fileExtention, String title}) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await getPermisionForStorage(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String downloadPath = '';
          List folders = directory.path.split('/');
          for (var i = 0; i < folders.length; i++) {
            String folder = folders[i];
            if (folder == 'Android') {
              break;
            }
            downloadPath += '/' + folders[i];
          }
          downloadPath += '/Astu-Guide/$title';

          directory = Directory(downloadPath);
        } else {
          return false;
        }
      } else {
        if (await getPermisionForStorage(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      print('-----');
      // print(directory.path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File storageFile = File(directory.path + '/$fileName.$fileExtention');
        // print(directory.path);
        await dio.download('$assetUrl/' + url, storageFile.path);
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(storageFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
    } catch (e) {
      // print(e);
      return false;
    }
    return false;
  }

  static Future getPermisionForStorage(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    }
    var askPermission = await permission.request();
    if (askPermission == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

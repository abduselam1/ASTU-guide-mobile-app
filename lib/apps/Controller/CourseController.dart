import 'dart:convert';
import 'dart:io';

import 'package:astu_guide/apps/Courses/Detail.dart';
import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CourseController {
  static Future courses({searchKeyWord}) async {
    var courses = await HiveService.get('courses');
    if (courses == false) {
      try {
        Response response = await UrlService.get('courses');
        await HiveService.put(boxName: 'courses', data: response.data);
      } catch (e) {
        print(e);
        return false;
      }
    }

    Map cacheCourses = await HiveService.get('courses');
    // String searchWord = searchKeyWord.trim();

    var filtered =
        cacheCourses[0].where((course) => whereCallback(course, searchKeyWord));

    return filtered.toList();
  }

  static bool whereCallback(course, searchKeyWord) {
    String creditHour = course['credit_hour'].toString();
    if (course['code']
            .toLowerCase()
            .contains(RegExp(searchKeyWord.trim().toLowerCase())) ||
        course['title'].toLowerCase().contains(RegExp(searchKeyWord.trim())) ||
        creditHour.toLowerCase().contains(RegExp(searchKeyWord.trim()))) {
      return true;
    }
    return false;
  }

  static buildList(course, context) {
    // print(course);
    String preRequest = '';
    String code = course['code'].substring(course['code'].length - 4);
    if (course['prerequisites'] == null)
      preRequest = "none";
    else
      preRequest = 'Have';
    return Card(
      // color: ASTUGuideTheme.teritiaryColor,
      elevation: 0.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            "$code",
            style: TextStyle(color: Colors.black),
          ),
        ),
        title: Text("${course['title']}"),
        subtitle: Text("Pre-request  $preRequest"),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios_rounded),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailCourses(
                          course: course,
                        )));
          },
        ),
      ),
    );
  }

  static Future<bool> materialDownload(resources, title) async {
    var fileStorage = json.decode(resources['file_storage_location']);
    // print(fileStorage);
    // print(fileStorage[0]['download_link']);
    bool isDownloaded = await UrlService.download(
        title: title,
        url: fileStorage[0]['download_link'],
        fileName: resources['file_name'],
        fileExtention: resources['file_type']);

    return isDownloaded;
  }

  static Future isResourcesAvailable(resources,title) async {
    Directory directory;
    if (Platform.isAndroid) {
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
      downloadPath +=
          '/Astu-Guide/$title/${resources['file_name']}.${resources['file_type']}';

      directory = Directory(downloadPath);
    } else {
      directory = await getTemporaryDirectory();
    }
    File file = File(directory.path);
    print(file.path);
    return [
      await file.exists(),
      file
    ];
    // if (await file.exists()) {
    //   return await file.exists();
    // } else {
    //   return await file.exists();
    // }
  }
}

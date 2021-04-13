import 'dart:convert';
import 'dart:io';

import 'package:astu_guide/apps/Controller/CourseController.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:astu_guide/common/services/url_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ResourceBody extends StatefulWidget {
  final Map resources;
  final String title;

  ResourceBody({this.resources, this.title});

  @override
  _ResourceBodyState createState() =>
      _ResourceBodyState(resources: resources, title: title);
}

class _ResourceBodyState extends State<ResourceBody> {
  bool isAvailable = false;
  Map resources;
  String title;
  bool isDownloading = false;
  _ResourceBodyState({this.resources, this.title});
  File filePath;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.0,
        child: ListTile(
          onTap: () {
            // print('hello');
            return CupertinoAlertDialog(
              content: Center(
                child: Text("somethign"),
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text("cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.resources['file_name']}",
                style: TextStyle(
                  fontSize: 21.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  "${widget.resources['file_size']} MB  ${widget.resources['file_type']}",
                  style: TextStyle(color: Colors.grey, fontSize: 13.0),
                ),
              )
            ],
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(
              "${widget.resources['description']}",
              style: TextStyle(
                  fontSize: 15.0, color: ASTUGuideTheme.textFadedColor2),
            ),
          ),
          trailing: CircleAvatar(
              child: FutureBuilder(
            future: CourseController.isResourcesAvailable(resources, title),
            builder: (context, snapshot) {
              // print(snapshot.data);
              if (snapshot.connectionState == ConnectionState.done) {
                // print(snapshot.data);

                return IconButton(
                  icon: (snapshot.data[0] == true || isAvailable == true)
                      ? Icon(Icons.file_copy_sharp)
                      : isDownloading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : Icon(Icons.download_sharp),
                  onPressed: snapshot.data[0]
                      ? () async {
                          File filePath = snapshot.data[1];
                          await OpenFile.open(filePath.path);
                        }
                      : () async {
                          setState(() {
                            isDownloading = true;
                          });
                          bool isDownloaded =
                              await CourseController.materialDownload(
                                  resources, title);
                          if (isDownloaded == true)
                            setState(() {
                              isAvailable = true;
                              isDownloading = false;
                            });
                          else
                            setState(() {
                              isDownloading = false;
                            });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: isDownloaded
                                  ? Text('Your file successfuly downloaded!')
                                  : Text(
                                      'Oops something went wrong please try again'),
                            ),
                          );
                        },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ));
  }
}

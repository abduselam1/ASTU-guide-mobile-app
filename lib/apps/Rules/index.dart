import 'package:astu_guide/apps/Controller/RuleController.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:astu_guide/apps/Rules/partials/body.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:astu_guide/common/services/Connection.dart';
import 'package:astu_guide/common/services/HiveService.dart';
import 'package:astu_guide/common/services/url_service.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class Rule extends StatefulWidget {
  @override
  _RuleState createState() => _RuleState();
}

class _RuleState extends State<Rule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules and Regulation'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: RuleController.rulesDataFromCache(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              if (snapshot.data == false) {
                return NetworkError();
              } else {
                return RulesBody(data: snapshot.data);
              }
            } else {
              return Center(
                child: Text("Something gone wrong please try again"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.width * 0.2,
//                       decoration: BoxDecoration(
//                         boxShadow:  [BoxShadow(blurRadius: 5,color: Colors.grey)],

//                       ),
//                       child: Row(

//                         children: [
//                           Expanded(
//                             flex: 1,
//                             child: Text("$snapshot.data[index]['article_number']"),
//                           ),
//                           Expanded(
//                             flex: 4,
//                             child: Column(
//                               children: [
//                               Text("$snapshot.data[index]['title]"),
//                               Text("$snapshot.data[index]['body']")
//                               ],
//                             ),
//                           )

//                         ]
//                       ),
//                     );

// ListTile(
//         leading: CircleAvatar(backgroundColor: ASTUGuideTheme.secondaryColor,child: Center(child: Text("${data['article_number']}",style: TextStyle(color:Colors.white),),),),
//         title: Text(data['title']),
//         subtitle: Text(body),
//         onTap: (){
//           if (detailedId == data['id']) {
//             setState(() {
//               detailedId = null;
//             });
//           }else{
//             setState(() {
//               detailedId = data['id'];
//             });
//           }
//           // if (data['body'].length > 100) {
//           //   if (!is_long) {
//           //     print('long');
//           //     is_long = !is_long;

//           //   }else{
//           //     print('shorten');
//           //     is_long = !is_long;
//           //     body = data['body'].substring(0,100)+' ...';
//           //   }
//           // }
//         },
//       ),

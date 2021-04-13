
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/material.dart';

class RulesBody extends StatefulWidget {
  dynamic data;
  RulesBody({this.data});

  @override
  _RulesBodyState createState() => _RulesBodyState(data: data);
}

class _RulesBodyState extends State<RulesBody> {
  
  dynamic data;
  _RulesBodyState({this.data});

  Widget listOfCard(dynamic datas){
    
    return Card(
      child: ExpansionTile(
        title: Text("${datas['title']}"),
        subtitle: Text(datas['body'].substring(0,40)+'...'),
        leading: CircleAvatar(backgroundColor: ASTUGuideTheme.secondaryColor,child: Text('${datas['article_number']}',style: TextStyle(color: Colors.white),),),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
            child: Text(
              "${datas['body']}",
              style: TextStyle(
                fontSize: 20.0
              ),
            ),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,index){
        var datas = data[index];
        // String test= '{name:"abduslam",age:32}';
        // var decodedData = jsonDecode(snapshot.data[0]);
        
        return listOfCard(datas);

      },
    );
  }
}
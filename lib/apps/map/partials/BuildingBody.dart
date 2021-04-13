import 'package:astu_guide/apps/map/partials/map.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/material.dart';

class BuildingBody extends StatelessWidget {
  dynamic building;
  BuildingBody({this.building});

  
 
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: ListTile(
        
        leading: CircleAvatar(
          backgroundColor: ASTUGuideTheme.primaryColor,
          child: Center(child: Text("${building['building_number']}")),
        ),
        title: Text("${building['building_name']}"),
        subtitle: Text("${building['description']}"),
        trailing: IconButton(
          icon: Icon(Icons.map),
          onPressed: (){
            Navigator.push(
              context,MaterialPageRoute(builder: (context) => BuildingMap(data: building))
            );
          },
        ),
      ),
      
    );
  }
}
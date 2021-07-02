import 'package:astu_guide/apps/lost_id/controllers/lost_id_controller.dart';
import 'package:astu_guide/apps/lost_id/lost_id_add.dart';
import 'package:astu_guide/apps/lost_id/partials/lost_id_list_tile.dart';
import 'package:astu_guide/apps/Rules/partials/NetworkError.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/material.dart';

class LostIdView extends StatefulWidget {
  @override
  _LostIdViewState createState() => _LostIdViewState();
}

class _LostIdViewState extends State<LostIdView> {
  List idd = [];
  final TextEditingController _searchKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ASTUGuideTheme.primaryColor,
      appBar: AppBar(
        title: Text("Lost ID"),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: LostIdController().lostIds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return NetworkError();
            }
            if (snapshot.data.isEmpty) {
              return Center(
                child: Text("Nothing found"),
              );
            }

            return Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 30,
                      bottom: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, .3),
                          blurRadius: 2,
                        )
                      ],
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          // margin: EdgeInsets.all(5.0),
                          // padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(12, 12, 12, 0.05),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(Icons.search),
                        ),
                        contentPadding: EdgeInsets.all(20.0),
                        hintStyle: TextStyle(color: Colors.black38),
                        border: InputBorder.none,
                        hintText: "Search...",
                      ),
                      onChanged: (value) {
                        // setState(() {
                        //   searchKeyWord = value;
                        // });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return LostIdListTile(
                          lostId: snapshot.data[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LostIdAdd()));
        },
        child: Icon(Icons.add),
        backgroundColor: ASTUGuideTheme.primaryColor,
      ),
    );
  }
}

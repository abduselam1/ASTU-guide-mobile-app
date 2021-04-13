import 'package:astu_guide/apps/auth/models/user_model.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final UserModel user;
  CustomAppBar({Key key, @required this.user}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () => {},
        child: AppBar(
          title: Text(
            'Search for courses',
            style: TextStyle(color: Colors.black54, fontSize: 17.0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 3.0,
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black54,
              ),
              iconSize: 28.0,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: ASTUGuideTheme.primaryColor,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

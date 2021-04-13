import 'package:astu_guide/apps/Courses/CoursesView.dart';
import 'package:astu_guide/apps/LostID/LostIdView.dart';
import 'package:astu_guide/apps/auth/controllers/login_controller.dart';
import 'package:astu_guide/apps/auth/models/user_model.dart';
import 'package:astu_guide/apps/map/BuildingView.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppDrawer extends StatefulWidget {
  final UserModel user;

  const CustomAppDrawer({Key key, @required this.user}) : super(key: key);
  @override
  _CustomAppDrawerState createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                backgroundColor: ASTUGuideTheme.secondaryColor,
                child: IconButton(
                  icon: Icon(Icons.exit_to_app, color: Colors.white),
                  onPressed: () => LoginController.logout(
                    context,
                    needConfirmation: true,
                  ),
                ),
              )
            ],
            decoration: BoxDecoration(
              color: ASTUGuideTheme.primaryColor,
            ),
            accountName: Text(widget.user.name),
            accountEmail: Text(widget.user.email),
            currentAccountPicture: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: ASTUGuideTheme.secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.call_split),
            title: Text('Curriculum'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.layers),
            title: Text('Courses'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CourseView()));
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Map'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BuildingView()));
            },
          ),
          Divider(height: 1),
          ListTile(
            title: Text('Lost ASTU ID & ATM'),
          ),
          ListTile(
            leading: Icon(Icons.add_to_photos_rounded),
            title: Text('Add ATM'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LostIdView()));
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search for lost ATM'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_to_photos_rounded),
            title: Text('Add ASTU ID'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search for lost ASTU ID'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Dev ASTU'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Contributors'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

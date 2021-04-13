import 'package:astu_guide/apps/auth/controllers/register_controller.dart';
import 'package:astu_guide/apps/auth/views/partials/register_form.dart';
import 'package:astu_guide/apps/dashboard/views/dashboard.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  static String school = "";
  static String department = "";
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirmation = TextEditingController();

  final TextEditingController _astuId = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _section = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ASTU Guide Registration'),
        ),
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: RegisterForm(
                        formKey: _formKey,
                        email: _email,
                        password: _password,
                        passwordConfirmation: _passwordConfirmation,
                        name: _name,
                        phoneNumber: _phoneNumber,
                        astuId: _astuId,
                        year: _year,
                        section: _section,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: loading
            ? FloatingActionButton(
                onPressed: () => {},
                backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : FloatingActionButton(
                onPressed: register,
                child: Icon(Icons.arrow_forward),
                backgroundColor: ASTUGuideTheme.primaryColor,
              ),
      ),
    );
  }

  register() async {
    if (_formKey.currentState.validate()) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        setState(() => loading = true);

        await RegisterController.register(
          name: _name.text.trim(),
          email: _email.text.trim(),
          phoneNumber: _phoneNumber.text.trim(),
          password: _password.text.trim(),
          astuId: _astuId.text.trim(),
          school: RegisterView.school.trim(),
          department: RegisterView.department.trim(),
          year: _year.text.trim(),
          section: _section.text.trim(),
        ).then((value) {
          if (value) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardView(),
              ),
              (route) => false,
            );
          } else {
            setState(() => loading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'These credentials do not match our records.',
                  style: TextStyle(color: Colors.redAccent),
                ),
                duration: Duration(seconds: 10),
              ),
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No Internet Connection!'),
          ),
        );
      }
    }
  }
}

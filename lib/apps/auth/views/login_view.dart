import 'package:astu_guide/apps/auth/controllers/login_controller.dart';
import 'package:astu_guide/apps/auth/views/forgot_password_view.dart';
import 'package:astu_guide/apps/auth/views/partials/login_form.dart';
import 'package:astu_guide/apps/dashboard/views/dashboard.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:astu_guide/common/views/partials/confirm_exit_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ConfirmExitDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/img/student_looking_mobile.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .5),
                                blurRadius: 20.0,
                                offset: Offset(0, 10),
                              )
                            ],
                          ),
                          child: LoginForm(
                            formKey: _formKey,
                            email: _email,
                            password: _password,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton.icon(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 15.0,
                                ),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordView(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                color: ASTUGuideTheme.secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                icon: const Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'New User? Sign Up',
                                ),
                                textColor: Colors.white,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordView(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: ASTUGuideTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                  onPressed: login,
                  child: Icon(Icons.arrow_forward),
                  backgroundColor: ASTUGuideTheme.primaryColor,
                ),
        ),
      ),
    );
  }

  login() async {
    if (_formKey.currentState.validate()) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none || true) {
        setState(() => loading = true);
        String email = _email.text.trim();
        String password = _password.text.trim();
        await LoginController.login(email: email, password: password)
            .then((value) {
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

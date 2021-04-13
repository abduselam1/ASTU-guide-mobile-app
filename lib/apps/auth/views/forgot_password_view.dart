import 'package:astu_guide/apps/auth/controllers/forgot_password_controller.dart';
import 'package:astu_guide/apps/auth/controllers/login_controller.dart';
import 'package:astu_guide/apps/auth/views/login_view.dart';
import 'package:astu_guide/apps/auth/views/partials/forgot_password_form.dart';
import 'package:astu_guide/apps/auth/views/password_reset_view.dart';
import 'package:astu_guide/apps/auth/views/register_view.dart';
import 'package:astu_guide/apps/dashboard/views/dashboard.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:astu_guide/common/views/partials/confirm_exit_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

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
                        image: AssetImage('assets/img/email_send.png'),
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
                          child: ForgotPasswordForm(
                            formKey: _formKey,
                            email: _email,
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterView(),
                                    ),
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
                                      builder: (context) => LoginView(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text(
                                  'Have an account? Login',
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
                  onPressed: forgotPassword,
                  child: Icon(Icons.arrow_forward),
                  backgroundColor: ASTUGuideTheme.primaryColor,
                ),
        ),
      ),
    );
  }

  forgotPassword() async {
    if (_formKey.currentState.validate()) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        setState(() => loading = true);

        String email = _email.text.trim();

        await ForgotPasswordController.forgotPassword(email: email)
            .then((value) {
          if (value) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => PasswordResetView(email: email),
              ),
              (route) => false,
            );
          } else {
            setState(() => loading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'We can\'t find a user with that email address.',
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

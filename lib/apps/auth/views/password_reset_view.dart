import 'package:astu_guide/apps/auth/controllers/password_reset_controller.dart';
import 'package:astu_guide/apps/auth/views/forgot_password_view.dart';
import 'package:astu_guide/apps/auth/views/login_view.dart';
import 'package:astu_guide/apps/auth/views/partials/password_reset_form.dart';
import 'package:astu_guide/apps/auth/views/register_view.dart';
import 'package:astu_guide/apps/dashboard/views/dashboard.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:astu_guide/common/views/partials/confirm_exit_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordResetView extends StatefulWidget {
  final String email;

  const PasswordResetView({Key key, @required this.email}) : super(key: key);
  @override
  _PasswordResetViewState createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends State<PasswordResetView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _passwordConfirmation = TextEditingController();

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
    if (widget.email == null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
        (Route<dynamic> route) => false,
      );
    }
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
                  Container(
                    child: Wrap(
                      children: [
                        Icon(
                          Icons.warning,
                          color: ASTUGuideTheme.primaryColor,
                        ),
                        Text(
                          "We have sent a password reset code to ${widget.email}",
                          style: TextStyle(
                            color: ASTUGuideTheme.primaryColor,
                          ),
                        ),
                      ],
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
                          child: PasswordResetForm(
                            email: widget.email,
                            formKey: _formKey,
                            code: _code,
                            newPassword: _newPassword,
                            passwordConfirmation: _passwordConfirmation,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                  onPressed: passwordReset,
                  child: Icon(Icons.arrow_forward),
                  backgroundColor: ASTUGuideTheme.primaryColor,
                ),
        ),
      ),
    );
  }

  passwordReset() async {
    if (_formKey.currentState.validate()) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        setState(() => loading = true);
        await PasswordResetController.reset(
          email: widget.email,
          code: _code.text.trim(),
          newPassword: _newPassword.text.trim(),
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
                  'Invalid code or the code has expired',
                  style: TextStyle(color: Colors.redAccent),
                ),
                action: SnackBarAction(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordView(),
                      ),
                      (route) => false,
                    );
                  },
                  label: 'Send code again',
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController email,
    @required TextEditingController password,
  })  : formKey = formKey,
        email = email,
        password = password,
        super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 13.0),
                    child: Icon(
                      Icons.email,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter email address";
                      } else if (!value.contains('@')) {
                        return "Invalid email address";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 5.0),
                      hintText: "Email",
                      hintStyle:
                          TextStyle(fontSize: 15.0, color: Colors.grey[400]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 13.0),
                    child: Icon(
                      Icons.vpn_key_rounded,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: password,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 5.0),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

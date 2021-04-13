import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordResetForm extends StatelessWidget {
  const PasswordResetForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController code,
    @required TextEditingController newPassword,
    @required TextEditingController passwordConfirmation,
    @required String email,
  })  : formKey = formKey,
        code = code,
        newPassword = newPassword,
        passwordConfirmation = passwordConfirmation,
        email = email,
        super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController code;
  final TextEditingController newPassword;
  final TextEditingController passwordConfirmation;
  final String email;

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
                      Icons.code,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: code,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter 4 digits reset code you received";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 5.0),
                      hintText: "4 digits reset code",
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
                    controller: newPassword,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter new password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 5.0),
                      hintText: "New Password",
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
                    controller: passwordConfirmation,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Confirm your password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 5.0),
                      hintText: "Confirm Password",
                      hintStyle:
                          TextStyle(fontSize: 15.0, color: Colors.grey[400]),
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

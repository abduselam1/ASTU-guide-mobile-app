import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController email,
  })  : formKey = formKey,
        email = email,
        super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController email;

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
        ],
      ),
    );
  }
}

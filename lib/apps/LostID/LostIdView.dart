import 'package:astu_guide/apps/Controller/LostIdController.dart';
import 'package:astu_guide/apps/LostID/LostIdShow.dart';
import 'package:astu_guide/apps/auth/views/partials/custom_text_form_field.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:astu_guide/main.dart';
import 'package:flutter/material.dart';

class LostIdView extends StatefulWidget {
  @override
  _LostIdViewState createState() => _LostIdViewState();
}

class _LostIdViewState extends State<LostIdView> {
  bool loading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _id = TextEditingController();
  String type;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register a lost card'),
        ),
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: _name,
                              labelText: "Name",
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Enter full name";
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField(
                              validator: (value) {
                                if (value == null) {
                                  return "Field can't be blank";
                                }
                                return null;
                              },
                              decoration: inputDecorationDropdown('Card Type',
                                  right: false),
                              isExpanded: true,
                              value: type,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              onChanged: (String newValue) => setState(() {
                                type = newValue;
                              }),
                              items: <String>[
                                "Student ID",
                                "ATM card",
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            CustomTextFormField(
                              controller: _id,
                              labelText: "Card id",
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Enter id of the ATM or student ID card";
                                }
                                return null;
                              },
                            ),
                            CustomTextFormField(
                              controller: _phoneNumber,
                              labelText: "Phone Number",
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Enter your phone number";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
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
      setState(() {
        loading = true;
      });
      var register = await LostIdController().register(
        name: _name.text.trim(),
        type: type,
        id: _id.text.trim(),
        phoneNumber: _phoneNumber.text.trim(),
      );
      if (register == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You have successfuly registered.',
              style: TextStyle(color: Colors.redAccent),
            ),
            duration: Duration(seconds: 10),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LostIdShow()),
          
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Oops there is something went wrong.',
              style: TextStyle(color: Colors.redAccent),
            ),
            duration: Duration(seconds: 10),
          ),
        );
      }
      setState(() {
        loading = false;
      });
    }
  }

  InputDecoration inputDecorationDropdown(labelText, {right = true}) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: right
            ? BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
        borderSide: BorderSide(
          color: ASTUGuideTheme.teritiaryColor,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ASTUGuideTheme.primaryColor,
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ASTUGuideTheme.primaryColor,
          width: 1.0,
        ),
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        fontSize: 20.0,
        color: ASTUGuideTheme.secondaryColor,
      ),
    );
  }
}

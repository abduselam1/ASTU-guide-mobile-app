import 'package:astu_guide/apps/auth/views/partials/custom_text_form_field.dart';
import 'package:astu_guide/apps/auth/views/register_view.dart';
import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterForm extends StatefulWidget {
  RegisterForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController email,
    @required TextEditingController password,
    @required TextEditingController name,
    @required TextEditingController phoneNumber,
    @required TextEditingController passwordConfirmation,
    @required TextEditingController astuId,
    @required TextEditingController year,
    @required TextEditingController section,
  })  : formKey = formKey,
        name = name,
        email = email,
        password = password,
        passwordConfirmation = passwordConfirmation,
        phoneNumber = phoneNumber,
        astuId = astuId,
        year = year,
        section = section,
        super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController phoneNumber;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController passwordConfirmation;

  final TextEditingController astuId;
  final TextEditingController year;
  final TextEditingController section;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String school;
  String deparment;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: widget.formKey,
            child: Column(
              children: <Widget>[
                CustomTextFormField(
                  controller: widget.name,
                  labelText: "Name",
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter full name";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: widget.email,
                  labelText: "Email",
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter email address";
                    } else if (!value.contains('@')) {
                      return "Invalid email address";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: widget.phoneNumber,
                  labelText: "Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter phone number";
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        leftRadius: true,
                        controller: widget.password,
                        labelText: "Password",
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter password";
                          } else if (value.length < 8) {
                            return "Must be at least 8 character";
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        rightRadius: true,
                        controller: widget.passwordConfirmation,
                        labelText: "Confirm Password",
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Confirm password";
                          } else if (value.trim() !=
                              widget.password.text.trim()) {
                            return "Password must match";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: Center(
                    child: Text('Academic Info'),
                  ),
                ),
                CustomTextFormField(
                  controller: widget.astuId,
                  labelText: "ASTU Id",
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter ASTU Id";
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Field can't be blank";
                            }
                            return null;
                          },
                          decoration:
                              inputDecorationDropdown('School', right: false),
                          isExpanded: true,
                          value: school,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          onChanged: (String newValue) => setState(() {
                            school = newValue;
                            RegisterView.school = newValue;
                          }),
                          items: <String>[
                            "EEC",
                            "CES",
                            "MES",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Field can't be blank";
                            }
                            return null;
                          },
                          decoration: inputDecorationDropdown('Department',
                              right: true),
                          isExpanded: true,
                          value: deparment,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          onChanged: (String newValue) => setState(() {
                            deparment = newValue;
                            RegisterView.department = newValue;
                          }),
                          items: <String>[
                            "CSE",
                            "ECE",
                            "PCE",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        leftRadius: true,
                        controller: widget.year,
                        labelText: "Year",
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter year";
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        rightRadius: true,
                        controller: widget.section,
                        labelText: "Section",
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter section";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
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

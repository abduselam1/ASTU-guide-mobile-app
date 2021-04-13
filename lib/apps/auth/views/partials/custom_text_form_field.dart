import 'package:astu_guide/common/constants/astu_guide_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key key,
    @required this.controller,
    @required this.validator,
    @required this.keyboardType,
    @required this.labelText,
    this.obscureText,
    this.rightRadius,
    this.leftRadius,
  }) : super(key: key);

  final TextEditingController controller;
  final Function validator;
  final TextInputType keyboardType;
  final String labelText;
  final bool obscureText;
  final bool rightRadius;
  final bool leftRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText ?? false,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius(),
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
            fontSize: 15.0,
            color: ASTUGuideTheme.secondaryColor,
          ),
        ),
      ),
    );
  }

  BorderRadius borderRadius() {
    if (rightRadius != null) {
      return BorderRadius.only(
        topRight: Radius.circular(5.0),
        bottomRight: Radius.circular(5.0),
      );
    } else if (leftRadius != null) {
      return BorderRadius.only(
        topLeft: Radius.circular(5.0),
        bottomLeft: Radius.circular(5.0),
      );
    }
    return BorderRadius.circular(5.0);
  }
}

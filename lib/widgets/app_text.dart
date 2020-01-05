import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AppText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;

  AppText(
    this.label,
    this.hint, {
    this.password = false,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.blue,
        ),
      ),
    );
  }
}

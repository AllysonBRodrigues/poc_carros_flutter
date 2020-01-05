import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String label;
  Function onPressed;

  AppButton(this.label, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 48,
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

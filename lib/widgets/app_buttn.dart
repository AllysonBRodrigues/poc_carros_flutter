import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String label;
  Function onPressed;
  bool showProgress;

  AppButton(this.label, {this.onPressed, this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: RaisedButton(
        color: Colors.blue,
        child: _animationButton(),
        onPressed: onPressed,
      ),
    );
  }

  _animationButton() {
    if (this.showProgress) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      );
    }
  }
}

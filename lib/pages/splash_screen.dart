import 'package:carros/dao/db_helper.dart';
import 'package:carros/model/user.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future futureDb = DatabaseHelper.getInstance().db;

    Future futureDelay = Future.delayed(Duration(seconds: 3));

    Future futureUser = User.get();

    Future.wait([futureDb, futureUser, futureDelay]).then((List values) {
      if (values[1] != null) {
        push(context, HomPage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

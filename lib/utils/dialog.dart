import 'package:flutter/material.dart';

confirmAlert(context, message,{Function callback}) {
  showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Alerta"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                if(callback != null) {
                   callback();
                }
              },
            )
          ],
        ),
      );
    },
  );
}
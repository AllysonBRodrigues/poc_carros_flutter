import 'package:flutter/material.dart';

confirmAlert(context, message, {Function callback}) {
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
                if (callback != null) {
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

progressDialog(context, showProgressStrem,
    {String message, Function callback}) {
  showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Alerta"),
          content: StreamBuilder<bool>(
              stream: showProgressStrem,
              builder: (context, snapshot) {
                final showProgress = snapshot.data ?? true;
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[_showProgress(showProgress, context, callback)],
                  ),
                );
              }),
          actions: <Widget>[
             FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                if (callback != null) {
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

_showProgress(show, context, callback) {
  if (show) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  } else {
    return Column(
          children:<Widget>[ Text(
        "teste",
        style: TextStyle(
          fontSize: 14,
          color: Colors.blue,
        ),
      ),
      ],
    );
  }
}

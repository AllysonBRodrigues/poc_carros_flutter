import 'package:flutter/material.dart';

appbar(String title) {
  return AppBar(
    title: Text(title),
    bottom: TabBar(
      tabs: <Widget>[
        Tab(
          text: "Clássicos",
        ),
        Tab(
          text: "Esportivos",
        ),
        Tab(
          text: "Luxo",
        ),
      ],
    ),
  );
}

appbarLogin(String title) {
  return AppBar(
    title: Text(title),
  );
}

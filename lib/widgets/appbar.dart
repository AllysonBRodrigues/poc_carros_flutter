import 'package:flutter/material.dart';

appbar(String title) {
  return AppBar(
    title: Text(title),
    bottom: TabBar(
      tabs: <Widget>[
        Tab(
          text: "Clássicos",
          icon: Icon(Icons.directions_car),
        ),
        Tab(
          text: "Esportivos",
          icon: Icon(Icons.directions_car),
        ),
        Tab(
          text: "Luxo",
          icon: Icon(Icons.directions_car),
        ),
        Tab(
          icon: Icon(Icons.favorite),
          text: "Favoritos",
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

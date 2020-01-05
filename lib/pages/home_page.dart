import 'package:carros/widgets/appbar.dart';
import 'package:flutter/material.dart';

class HomPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Carros"),
      body: _body(),
    );
  }
}

_body() {
  return Center(
    child: Text(
      "Usuário",
      style: TextStyle(
        fontSize: 22
      ),
    ),
  );

}
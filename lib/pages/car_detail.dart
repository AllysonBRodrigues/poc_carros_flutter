import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/cars.dart';

class CarDetail extends StatelessWidget {
  Cars car;

  CarDetail(this.car);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(car.nome)),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
        child: Image.network(car.urlFoto)
    );
  }
}

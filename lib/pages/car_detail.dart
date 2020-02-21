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
      appBar: AppBar(
        title: Text(car.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMap,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _onClickPopupMenu(value),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text("Share"),
                ),

              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
        padding: EdgeInsets.all(16), child: Image.network(car.urlFoto));
  }

  void _onClickMap() {}



  void _onClickVideo() {
  }

  _onClickPopupMenu(String value) {
    switch(value) {
      case "Editar":
        print("Editar!");
        break;
      case "Deletar":
        print("Deletar!");
        break;
      case "Share":
        print("Share");
        break;
    }
  }
}

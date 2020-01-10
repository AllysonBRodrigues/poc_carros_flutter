import 'package:carros/enuns/status.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/model/result.dart';
import 'package:carros/network/cars_api.dart';
import 'package:carros/widgets/appbar.dart';
import 'package:carros/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class HomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Carros"),
      body: _body(),
      drawer: DrawerList(),
    );
  }
}

_body() {
  return FutureBuilder(
    future: CarsApi.getCars(),
    builder: (context, snapshot) {
      if(snapshot.hasError){
        print(snapshot.error);
        return Center(
          child: Text(
            "Error ao recuperar lista",
            style: TextStyle(fontSize: 20),
          ),
        );
      }

      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      Result<List<Cars>> cars = snapshot.data;

      if (cars.status == Status.SUCCESS) {
        return _listCars(cars.data);
      } else {
        return Center(
          child: Text(
            cars.message,
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    },
  );
}

Container _listCars(List<Cars> cars) {
  return Container(
    padding: EdgeInsets.all(16),
    child: ListView.builder(
      itemCount: cars != null ? cars.length : 0,
      itemBuilder: (BuildContext context, int index) {
        Cars car = cars[index];
        return Card(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.network(
                    car.urlFoto ?? "https://www.bauducco.com.br/wp-content/uploads/2017/09/default-placeholder-1-2.png",
                    width: 250,
                  ),
                ),
                Text(
                  car.nome,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Descrição...",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text(
                        'DETALHES',
                      ),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    FlatButton(
                      child: const Text('SHARE'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

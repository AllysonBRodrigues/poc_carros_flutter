import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/pages/car_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../utils/nav.dart';

class CarListView extends StatelessWidget {
  List<Car> cars;

  CarListView(this.cars);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: cars != null ? cars.length : 0,
        itemBuilder: (BuildContext context, int index) {
          Car car = cars[index];
          return Container(
            height: 280,
            child: InkWell(
              onTap: () {
                push(context, CarDetail(car));
              },
              onLongPress: () {
                _onLongClickCar(context, car);
              },
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: car.urlFoto ??
                              "https://saints-auto.com/wp-content/uploads/2017/06/car-placeholder-2-700.jpg",
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
                              push(context, CarDetail(car));
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
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

void _onLongClickCar(BuildContext context, Car car) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                car.nome,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              title: Text("Detalhe"),
              leading: Icon(Icons.directions_car),
              onTap: () {
                Navigator.pop(context);
                push(context, CarDetail(car));
              },
            ),
            ListTile(
              title: Text("Compartilhar"),
              leading: Icon(Icons.share),
              onTap: () {
                Share.share(car.urlFoto);
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

import 'package:carros/block/cars_block.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/pages/car_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/nav.dart';

class CarsListView extends StatefulWidget {
  String carTypes;

  CarsListView(this.carTypes);

  @override
  _CarsListViewState createState() => _CarsListViewState();
}

class _CarsListViewState extends State<CarsListView>
    with AutomaticKeepAliveClientMixin<CarsListView> {
  List<Cars> cars;
  final bloc = CarsBloc();

  @override
  void initState() {
    super.initState();
    bloc.loadCars(widget.carTypes);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    return StreamBuilder(
        stream: bloc.strean,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Não foi possivel carregar lista",
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }

          return _listCars(snapshot.data);
        });
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
                      car.urlFoto ??
                          "https://www.bauducco.com.br/wp-content/uploads/2017/09/default-placeholder-1-2.png",
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
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }
}

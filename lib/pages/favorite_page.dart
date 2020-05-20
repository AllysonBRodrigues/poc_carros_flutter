import 'package:carros/main.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/model/favoritos_model.dart';
import 'package:carros/pages/car_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with AutomaticKeepAliveClientMixin<FavoritePage> {


  @override
  void initState() {
    super.initState();
    FavoritosModel model = Provider.of<FavoritosModel>(context, listen: false);
    model.getCars();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    FavoritosModel model = Provider.of<FavoritosModel>(context);

    List<Car> cars = model.cars;

    if (cars.isEmpty) {
      return Center(
        child: Text(
          "Nenhum carro nos favoritos", style: TextStyle(fontSize: 20),),
      );
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CarListView(cars),
    );

  }

  Future<void> _onRefresh() {
    FavoritosModel model = Provider.of<FavoritosModel>(context, listen: false);
    return model.getCars();
  }

  @override
  bool get wantKeepAlive => false;
}

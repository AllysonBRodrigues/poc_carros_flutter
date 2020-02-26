import 'dart:async';

import 'package:carros/model/cars.dart';
import 'package:carros/network/cars_api.dart';

class CarsBloc {
  final _streamController = StreamController<List<Cars>>();

  get strean => _streamController.stream;

  Future<List<Cars>> loadCars(String type) async {
    try {
      List<Cars> cars = await CarsApi.getCars(type);
      _streamController.add(cars);
      return cars;
    } catch (e){
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}

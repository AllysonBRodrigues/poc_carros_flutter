import 'dart:async';

import 'package:carros/dao/cars_dao.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/network/cars_api.dart';
import 'package:carros/utils/network.dart';

class CarsBloc {
  final _streamController = StreamController<List<Cars>>();

  get strean => _streamController.stream;

  Future<List<Cars>> loadCars(String type) async {
    try {
      bool networkOn = await isNetworkOn();

      if (!networkOn) {
        List<Cars> cars = await CarsDao().findAllByTipo(type);
        _streamController.add(cars);
        return cars;
      }

      List<Cars> cars = await CarsApi.getCars(type);
      final dao = CarsDao();
      cars.forEach(dao.save);

      _streamController.add(cars);
      return cars;
    } catch (e) {
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}

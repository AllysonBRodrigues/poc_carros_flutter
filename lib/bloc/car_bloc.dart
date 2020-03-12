import 'dart:async';

import 'package:carros/bloc/base_bloc.dart';
import 'package:carros/dao/cars_dao.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/network/cars_api.dart';
import 'package:carros/utils/network.dart';

class CarBloc extends BaseBloc<List<Car>>{

  Future<List<Car>> fetch(String type) async {
    try {
      bool networkOn = await isNetworkOn();

      if (!networkOn) {
        List<Car> cars = await CarsDao().findAllByTipo(type);
        add(cars);
        return cars;
      }

      List<Car> cars = await CarsApi.getCars(type);
      final dao = CarsDao();
      cars.forEach(dao.save);
      add(cars);
      return cars;
    } catch (e) {
      addError(e);
    }
  }

 dispose() {
    dispose();
  }
}

import 'dart:async';

import 'package:carros/bloc/base_bloc.dart';
import 'package:carros/dao/cars_dao.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/network/cars_api.dart';
import 'package:carros/utils/network.dart';

class CarsBloc extends BaseBloc<List<Cars>>{

  Future<List<Cars>> fetch(String type) async {
    try {
      bool networkOn = await isNetworkOn();

      if (!networkOn) {
        List<Cars> cars = await CarsDao().findAllByTipo(type);
        add(cars);
        return cars;
      }

      List<Cars> cars = await CarsApi.getCars(type);
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

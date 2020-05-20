import 'dart:async';
import 'dart:io';

import 'package:carros/bloc/base_bloc.dart';
import 'package:carros/dao/cars_dao.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/model/result.dart';
import 'package:carros/network/cars_api.dart';
import 'package:carros/utils/network.dart';

class CarBloc extends BaseBloc<List<Car>>{

  final _controllerSaveCar = StreamController<bool>();
  final _controllerDeleteCar = StreamController<bool>();

  Stream<bool> get streamSaveCar => _controllerSaveCar.stream;
  Stream<bool> get streamDeleteCar => _controllerSaveCar.stream;

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

  Future<Result<bool>> save(Car car, File file) async {
    try {
      _controllerSaveCar.add(true);
      bool networkOn = await isNetworkOn();

      if (!networkOn) {
        _controllerSaveCar.add(false);
        return Result.error("Erro na coneção");
      }

      Result<bool> carSave = await CarsApi.saveCar(car, file);

      _controllerSaveCar.add(false);

      return carSave;
    } catch (e) {
      addError(e);
    }
  }

  Future<Result<bool>> delete(Car car) async {
    try {
      _controllerDeleteCar.add(true);
      bool networkOn = await isNetworkOn();

      if (!networkOn) {
        _controllerDeleteCar.add(false);
        return Result.error("Erro na coneção");
      }

      Result<bool> carSave = await CarsApi.deleteCar(car);
      
      _controllerDeleteCar.add(false);

      return carSave;
    } catch (e) {
      addError(e);
    }
  }

 dispose() {
    dispose();
    _controllerSaveCar.close();
    _controllerDeleteCar.close();
  }
}

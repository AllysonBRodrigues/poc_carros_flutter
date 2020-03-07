import 'dart:async';

import 'package:carros/bloc/base_bloc.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/repository/favorite_repository.dart';

class FavoriteBloc extends BaseBloc<List<Cars>> {
  Future<List<Cars>> featc() async {
    try {
      List<Cars> cars = await FavoriteRepository.getCars();
      add(cars);
      return cars;
    } catch (e) {
      addError(e);
    }
  }

  void dispose() {
    dispose();
  }
}

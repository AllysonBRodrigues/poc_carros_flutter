
import 'package:carros/model/cars.dart';
import 'package:carros/repository/favorite_repository.dart';
import 'package:flutter/material.dart';

class FavoritosModel extends ChangeNotifier{
  List<Car> cars = [];


  Future<List<Car>> getCars() async {
    cars = await FavoriteRepository.getCars();
    notifyListeners();
    return cars;
  }

}
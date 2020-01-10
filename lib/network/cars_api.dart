import 'dart:convert';

import 'package:carros/model/cars.dart';
import 'package:carros/model/result.dart';
import 'package:http/http.dart' as http;


class CarTypes{
  static final String classics = "classicos";
  static final String sports = "esportivos";
  static final String lux = "luxo";
}

class CarsApi {
  static Future<Result<List<Cars>>> getCars(String type) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$type';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List list = json.decode(response.body);
      List<Cars> cars = list.map<Cars>((map) => Cars.fromJson(map)).toList();
      return Result.success(cars);
    } else {
      return Result.error("Error ao recuperar lista");
    }
  }
}

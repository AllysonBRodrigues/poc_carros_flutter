import 'dart:convert';

import 'package:carros/model/cars.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class CarTypes {
  static final String classics = "classicos";
  static final String sports = "esportivos";
  static final String lux = "luxo";
}

class CarsApi {
  static Future<List<Cars>> getCars(String type) async {
    User user = await User.get();

    Map<String, String> headers = {
      "Content-Type": "aplication/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url =
        'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$type';
    var response = await http.get(url);
    List list = json.decode(response.body);
    List<Cars> cars = list.map<Cars>((map) => Cars.fromJson(map)).toList();
    return cars;
  }
}

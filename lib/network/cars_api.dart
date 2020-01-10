

import 'dart:convert';

import 'package:carros/model/cars.dart';
import 'package:carros/model/result.dart';
import 'package:http/http.dart' as http;

class CarsApi {
  static Future<Result<List<Cars>>> getCars() async{

    var url = 'https://carros-springboot.herokuapp.com/api/v1/carros';
    var response = await http.get(url);

    if(response.statusCode == 200){
      List list = json.decode(response.body);
      List<Cars> cars = list.map<Cars>((map) => Cars.fromJson(map)).toList();
      return Result.success(cars);
    }else{
      return Result.error("Error ao recuperar lista");
    }
  }
}
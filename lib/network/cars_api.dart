import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:carros/model/cars.dart';
import 'package:carros/model/result.dart';
import 'package:carros/network/upload_service.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class CarTypes {
  static final String classics = "classicos";
  static final String sports = "esportivos";
  static final String lux = "luxo";
}

class CarsApi {
  static Future<List<Car>> getCars(String type) async {
    User user = await User.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
     // "Authorization": "Bearer ${user.token}"
    };

    var url =
        'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$type';
    print(url);
    var response = await http.get(url, headers: headers);
    List list = json.decode(response.body);
    List<Car> cars = list.map<Car>((map) => Car.fromMap(map)).toList();
    return cars;
  }

  static Future<Result<bool>> saveCar(Car car, File file) async {
    try {
      User user = await User.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      if(file != null){
        final response = await UploadService.upload(file);
        car.urlFoto = response;
      }

      var url = 'https://carros-springboot.herokuapp.com/api/v1/carros';
      if (car.id != null) {
        url += "/${car.id}";
      }

      print(url);
      var t = car.toJson();
      var response = await (car.id == null
          ? http.post(url, body: t, headers: headers)
          : http.put(url, body: t, headers: headers));

      print("Status: ${response.statusCode}");
      print("Status: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Result.success(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return Result.error("Não foi possível salvar o carro");
      }

      Map mapResponse = convert.json.decode(response.body);
      return Result.error(mapResponse["error"]);
    } catch (e) {
      return Result.error("Não foi possível salvar o carro");
    }
  }

 static Future<Result<bool>> deleteCar(Car car) async {
    try {
      User user = await User.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/${car.id}';
      print(url);

      var response = await http.delete(url, headers: headers);

      print("Status: ${response.statusCode}");
      print("Status: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Result.success(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return Result.error("Não foi possível deletar o carro");
      }

      Map mapResponse = convert.json.decode(response.body);
      return Result.error(mapResponse["error"]);
    } catch (e) {
      return Result.error("Não foi possível deletar o carro");
    }
  }
}

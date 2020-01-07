import 'dart:convert';

import 'package:carros/model/User.dart';
import 'package:carros/model/result.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<Result> login(String login, String senha) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

      Map<String, String> headers = {"Content-Type": "aplication/json"};

      Map params = {'username': login, 'password': senha};

      var response =
          await http.post(url, body: json.encode(params), headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(mapResponse);
        return Result.success(user);
      }

      return Result.error(mapResponse["error"]);
    } catch (ex) {
      return Result.error("Ocorreu um erro ao executar o processo");
    }
  }
}

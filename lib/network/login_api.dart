import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<bool> login(String login, String senha) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

    Map<String, String> headers = {"Content-Type": "aplication/json"};

    Map params = {'username': login, 'password': senha};

    var response =
        await http.post(url, body: json.encode(params), headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return true;
  }
}

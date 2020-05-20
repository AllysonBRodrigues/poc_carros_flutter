import 'dart:convert';

import '../utils/prefs.dart';

class User {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  User(
      {this.id,
      this.login,
      this.nome,
      this.email,
      this.urlFoto,
      this.token,
      this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  void save() {
    Map map = toJson();
    String userJson = json.encode(map);
    Prefs.setString("user.prefs", userJson);
  }

  static Future<User> get() async {
    String userJson = await Prefs.getString("user.prefs");
    if (userJson == null || userJson.isEmpty) return null;

    Map map = json.decode(userJson);
    return User.fromJson(map);
  }

  static void clear() {
    Prefs.setString("user.prefs", null);
  }
}

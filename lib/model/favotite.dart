import 'package:carros/model/cars.dart';
import 'package:carros/model/entity.dart';

class Favorite extends Entity {
  int id;
  String nome;

  Favorite.fromCar(Cars car){
    id = car.id;
    nome = car.nome;
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }
}

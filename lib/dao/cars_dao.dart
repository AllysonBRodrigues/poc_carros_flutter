import 'package:carros/dao/base_dao.dart';
import 'package:carros/model/cars.dart';

class CarsDao extends BaseDao<Car> {
  @override
  String get tableName => "carro";

  @override
  fromMap(Map<String, dynamic> map) {
    return Car.fromMap(map);
  }

  Future<List<Car>> findAllByTipo(String tipo) {
    return query('select * from $tableName where tipo =? ', [tipo]);
  }
}

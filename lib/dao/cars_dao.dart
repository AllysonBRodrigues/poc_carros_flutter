import 'package:carros/dao/base_dao.dart';
import 'package:carros/model/cars.dart';

class CarsDao extends BaseDao<Cars> {
  @override
  String get tableName => "carro";

  @override
  fromMap(Map<String, dynamic> map) {
    return Cars.fromMap(map);
  }

  Future<List<Cars>> findAllByTipo(String tipo) {
    return query('select * from $tableName where tipo =? ', [tipo]);
  }
}

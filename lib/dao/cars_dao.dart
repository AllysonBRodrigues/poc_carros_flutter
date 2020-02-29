import 'package:carros/dao/base_dao.dart';
import 'package:carros/model/cars.dart';

class CarsDao extends BaseDao {
  @override
  String get tableName => "carro";

  @override
  fromMap(Map<String, dynamic> map) {
    return Cars.fromMap(map);
  }

  Future<List<Cars>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient
        .rawQuery('select * from $tableName where tipo =? ', [tipo]);

    final carros = list.map<Cars>((json) => fromMap(json)).toList();

    return carros;
  }
}

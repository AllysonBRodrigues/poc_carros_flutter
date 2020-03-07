import 'package:carros/dao/base_dao.dart';
import 'package:carros/model/favotite.dart';

class FavoriteDao extends BaseDao<Favorite>{
  @override
  Favorite fromMap(Map<String, dynamic> map) {
    return Favorite.fromMap(map);
  }

  @override
  String get tableName => "favorito";

}
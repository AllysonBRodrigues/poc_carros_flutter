import 'package:carros/dao/cars_dao.dart';
import 'package:carros/dao/favorite_dao.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/model/favoritos_model.dart';
import 'package:carros/model/favotite.dart';
import 'package:provider/provider.dart';

class FavoriteRepository {
  static Future<bool> favoritar(context, car) async {
    Favorite favorite = Favorite.fromCar(car);

    final dao = FavoriteDao();

    if (await dao.exists(car.id)) {
      dao.delete(car.id);
      FavoritosModel model = Provider.of<FavoritosModel>(context, listen: false);
      model.getCars();
      return false;
    } else {
      dao.save(favorite);
      FavoritosModel model = Provider.of<FavoritosModel>(context, listen: false);
      model.getCars();
      return true;
    }
  }

  static Future<List<Car>> getCars() async {
    List<Car> cars = await CarsDao()
        .query("select * from carro c,favorito f where c.id = f.id");
    return cars;
  }

  static Future<bool> isFavorite(Car car) async {
    final dao = FavoriteDao();
    return await dao.exists(car.id);
  }
}

import 'package:carros/dao/cars_dao.dart';
import 'package:carros/dao/favorite_dao.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/model/favotite.dart';

class FavoriteRepository{

  static favoritar(Cars car) async{
    Favorite favorite = Favorite.fromCar(car);

    final dao = FavoriteDao();

    if (await dao.exists(car.id)){
      dao.delete(car.id);
    }else{
      dao.save(favorite);
    }
  }

  static Future<List<Cars>> getCars()async{
    List<Cars> cars = await CarsDao().query("select * from carro c,favorito f where c.id = f.id");
    return cars;
  }
    
}
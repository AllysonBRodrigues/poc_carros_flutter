import 'package:carros/bloc/favorites_bloc.dart';
import 'package:carros/main.dart';
import 'package:carros/pages/car_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with AutomaticKeepAliveClientMixin<FavoritePage> {


  @override
  void initState() {
    super.initState();
    FavoriteBloc favoriteBloc = Provider.of<FavoriteBloc>(context, listen: false);
    favoriteBloc.featc();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    FavoriteBloc favoriteBloc = Provider.of<FavoriteBloc>(context);
    return StreamBuilder(
        stream: favoriteBloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Não foi possivel carregar lista",
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CarListView(snapshot.data),
          );
        });
  }

  Future<void> _onRefresh() {
    FavoriteBloc favoriteBloc = Provider.of<FavoriteBloc>(context);
    return favoriteBloc.featc();
  }

  @override
  bool get wantKeepAlive => false;
}

import 'package:carros/bloc/cars_bloc.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/pages/cars_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarsPage extends StatefulWidget {
  String carTypes;

  CarsPage(this.carTypes);

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage>
    with AutomaticKeepAliveClientMixin<CarsPage> {
  List<Cars> cars;
  final _bloc = CarsBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetch(widget.carTypes);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    return StreamBuilder(
        stream: _bloc.stream,
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
            child: CarsListView(snapshot.data),
          );
        });
  }

  Future<void> _onRefresh(){
    return _bloc.fetch(widget.carTypes);
  }

  @override
  bool get wantKeepAlive => true;

}

import 'package:carros/block/cars_block.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/pages/car_detail.dart';
import 'package:carros/pages/cars_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/nav.dart';

class CarsPage extends StatefulWidget {
  String carTypes;

  CarsPage(this.carTypes);

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage>
    with AutomaticKeepAliveClientMixin<CarsPage> {
  List<Cars> cars;
  final bloc = CarsBloc();

  @override
  void initState() {
    super.initState();
    bloc.loadCars(widget.carTypes);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    return StreamBuilder(
        stream: bloc.strean,
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
    return bloc.loadCars(widget.carTypes);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
  
    super.dispose();
    bloc.dispose();
  }
}

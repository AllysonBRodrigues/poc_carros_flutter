import 'dart:async';

import 'package:carros/bloc/car_bloc.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/pages/car_listview.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarPage extends StatefulWidget {
  String carTypes;

  CarPage(this.carTypes);

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage>
    with AutomaticKeepAliveClientMixin<CarPage> {
  List<Car> cars;
  final _bloc = CarBloc();

  StreamSubscription<Event> subscription;

  @override
  void initState() {
    super.initState();
    _bloc.fetch(widget.carTypes);

    final bus = EventBus.get(context);

    subscription = bus.stream.listen((Event event) {
      print("Event $event");
      CarEvent  carEvent = event;
      if(carEvent.type == widget.carTypes) {
        _bloc.fetch(widget.carTypes);
      }
    });


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
            child: CarListView(snapshot.data),
          );
        });
  }

  Future<void> _onRefresh(){
    return _bloc.fetch(widget.carTypes);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose(){
    super.dispose();
    _bloc.dispose();
    subscription.cancel();
  }

}

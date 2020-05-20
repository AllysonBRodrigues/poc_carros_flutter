import 'package:carros/network/cars_api.dart';
import 'package:carros/pages/car_form_page.dart';
import 'package:carros/pages/car_page.dart';
import 'package:carros/pages/favorite_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/appbar.dart';
import 'package:carros/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class HomPage extends StatefulWidget {
  @override
  _HomPageState createState() => _HomPageState();
}

class _HomPageState extends State<HomPage>
    with SingleTickerProviderStateMixin<HomPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: appbar("Carros"),
        body: TabBarView(children: [
          CarPage(CarTypes.classics),
          CarPage(CarTypes.sports),
          CarPage(CarTypes.lux),
          FavoritePage(),
        ]),
        drawer: DrawerList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _onClickAddCar),
      ),
    );
  }

  void _onClickAddCar() {
    push(context, CarroFormPage());
  }
}

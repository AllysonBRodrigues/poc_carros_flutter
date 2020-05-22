import 'package:carros/model/cars.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final Car car;

  MapPage(this.car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 17,
          target: car.latLgn(),
        ),
        markers: Set.of(_getMarkes()),
      ),
    );
  }

  List<Marker> _getMarkes() {
    return[
      Marker(
        markerId: MarkerId("1"),
        position: car.latLgn(),
        infoWindow: InfoWindow(
          title: car.nome,
          snippet: "Fabrica da ${car.nome}",
          onTap: (){
            print("Clicou na janela");
          }
        ),
          onTap: (){
            print("Clicou no marcador");
          }
      )
    ];
  }
}

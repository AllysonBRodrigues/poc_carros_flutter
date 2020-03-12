import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/bloc/lorem_ipsum_bloc.dart';
import 'package:carros/repository/favorite_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/cars.dart';

class CarDetail extends StatefulWidget {
  Car car;

  CarDetail(this.car);

  @override
  _CarDetailState createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  final _loripsumApiBloc = LoremIpsumBloc();

  Color color = Colors.grey;

  Car get car => widget.car;

  @override
  void initState() {
    super.initState();

    FavoriteRepository.isFavorite(car).then((favorite) {
      setState(() {
        color = favorite ? Colors.red : Colors.grey;
      });
    });

    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(widget.car.nome),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.place),
          onPressed: _onClickMap,
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: _onClickVideo,
        ),
        PopupMenuButton<String>(
          onSelected: (value) => _onClickPopupMenu(value),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: "Editar",
                child: Text("Editar"),
              ),
              PopupMenuItem(
                value: "Deletar",
                child: Text("Deletar"),
              ),
              PopupMenuItem(
                value: "Share",
                child: Text("Share"),
              ),
            ];
          },
        )
      ],
    );
  }

  _body() {
    return Container(
        padding: EdgeInsets.all(16),
        child: ListView(children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.car.urlFoto,
          ),
          header(),
          Divider(),
          descrition(),
        ]));
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.car.nome,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.car.tipo,
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 40,
              ),
              onPressed: _onClickFavorite,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40,
              ),
              onPressed: _onClickShare,
            ),
          ],
        )
      ],
    );
  }

  descrition() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text(
          widget.car.descricao,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
          stream: _loripsumApiBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Text(snapshot.data);
          },
        ),
      ],
    );
  }

  void _onClickVideo() {}

  void _onClickMap() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar!");
        break;
      case "Deletar":
        print("Deletar!");
        break;
      case "Share":
        print("Share");
        break;
    }
  }

  void _onClickFavorite() async {
    bool isFavorite = await FavoriteRepository.favoritar(car);
    setState(() {
      color = isFavorite ? Colors.red : Colors.grey;
    });
  }

  void _onClickShare() {}
}

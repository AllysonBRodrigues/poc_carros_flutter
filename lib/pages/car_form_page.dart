import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/bloc/car_bloc.dart';
import 'package:carros/enuns/status.dart';
import 'package:carros/model/cars.dart';
import 'package:carros/model/result.dart';
import 'package:carros/network/cars_api.dart';
import 'package:carros/utils/dialog.dart';
import 'package:carros/widgets/app_buttn.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarroFormPage extends StatefulWidget {
  final Car carro;

  CarroFormPage({this.carro});

  @override
  State<StatefulWidget> createState() => _CarroFormPageState();
}

class _CarroFormPageState extends State<CarroFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tNome = TextEditingController();
  final tDesc = TextEditingController();
  final tTipo = TextEditingController();

  final _carBloc = CarBloc();


  int _radioIndex = 0;

  var _showProgress = false;

  File _file;

  Car get carro => widget.carro;

  // Add validate email function.
  String _validateNome(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do carro.';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    // Copia os dados do carro para o form
    if (carro != null) {
      tNome.text = carro.nome;
      tDesc.text = carro.descricao;
      _radioIndex = getTipoInt(carro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          carro != null ? carro.nome : "Novo Carro",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerFoto(),
          Text(
            "Clique na imagem para tirar uma foto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          Text(
            "Tipo",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          _radioTipo(),
          Divider(),
          AppText(
            "Name",
            "",
            controller: tNome,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
           AppText(
            "Descrição",
            "",
            controller: tDesc,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
          StreamBuilder<bool>(
            stream: _carBloc.streamSaveCar,
            builder: (context, snapshot) {
              return AppButton(
                "Salvar",
                 onPressed: _onClickSalvar,
                 showProgress: snapshot.data ?? false,
              );
            }
          ),
        ],
      ),
    );
  }

  _headerFoto() {
    return InkWell(
      onTap: _onClickFoto,
      child:  _file != null
      ? Image.file(_file,height: 150,)
      :carro != null
          ? CachedNetworkImage(
        imageUrl: carro.urlFoto ?? "https://saints-auto.com/wp-content/uploads/2017/06/car-placeholder-2-700.jpg",
      )
          : Image.asset(
        "assets/images/camera.png",
        height: 150,
      ),
    );
  }

  _radioTipo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Clássicos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Esportivos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Luxo",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickTipo(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getTipoInt(Car carro) {
    switch (carro.tipo) {
      case "classicos":
        return 0;
      case "esportivos":
        return 1;
      default:
        return 2;
    }
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return "classicos";
      case 1:
        return "esportivos";
      default:
        return "luxo";
    }
  }

  _onClickSalvar() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Cria o carro
    var c = carro ?? Car();
    c.nome = tNome.text;
    c.descricao = tDesc.text;
    c.tipo = _getTipo();

    print("Carro: $c");

    print("Salvar o carro $c");

    Result<bool>  response = await _carBloc.save(c, _file);

    if(response.status == Status.SUCCESS){
      confirmAlert(context, "Carro Salvo com sucesso", callback: (){
        Navigator.pop(context);
      });
    } else {
      confirmAlert(context, "Erro ao salvar carro");
    }

    print("Fim.");
  }

   _onClickFoto() async{
    File  file = await ImagePicker.pickImage(source: ImageSource.camera);
    if(file != null){
      setState(() {
        this._file = file;
      });

    }
  }
}

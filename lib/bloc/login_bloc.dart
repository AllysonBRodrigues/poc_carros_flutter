import 'dart:async';

import 'package:carros/model/result.dart';
import 'package:carros/network/firebase_service.dart';
import 'package:carros/network/login_api.dart';

class LoginBloc {

  final _streamControler = StreamController<bool>();

  get stream => _streamControler.stream;

  Future<Result> login(String login, String senha) async {

    _streamControler.add(true);
    //Result ok = await LoginApi.login(login, senha);
    Result ok = await FirebaseService().emailSignIn(login, senha);

    _streamControler.add(false);
    return ok;
  }

  dispose(){
    _streamControler.close();
  }
}

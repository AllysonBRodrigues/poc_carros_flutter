import 'package:carros/block/login_block.dart';
import 'package:carros/enuns/status.dart';
import 'package:carros/model/result.dart';
import 'package:carros/network/login_api.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/utils/dialog.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_buttn.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:carros/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../utils/nav.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _tLogin = TextEditingController();
  var _tSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  final _block = LoginBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<User> future = User.get();
    future.then((User user) {
      if (user != null) {
        push(context, HomPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarLogin("Carros"),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite o login",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10,
            ),
            AppText("Senha", "Digite a senha",
                password: true,
                controller: _tSenha,
                validator: _validatePassword,
                keyboardType: TextInputType.number),
            SizedBox(
              height: 16,
            ),
            StreamBuilder<bool>(
              stream: _block.stream,
              builder: (context, snapshot) {
                return AppButton(
                  "Login",
                  onPressed: () {
                    _onClickLogin(context);
                  },
                  showProgress: snapshot.data ?? false,
                );
              }
            )
          ],
        ),
      ),
    );
  }

  _onClickLogin(context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      Result ok = await _block.login(_tLogin.text, _tSenha.text);

      if (ok.status == Status.SUCCESS) {
        push(context, HomPage(), replace: true);
      } else {
        confirmAlert(context, ok.message);
      }

      setState(() {
        loading = false;
      });
    }
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o login";
    }
    return null;
  }

  String _validatePassword(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _block.dispose();
  }
}

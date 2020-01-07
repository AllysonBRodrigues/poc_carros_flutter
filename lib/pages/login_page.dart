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

class LoginPage extends StatelessWidget {
  var _tLogin = TextEditingController();
  var _tSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Carros"),
      body: _body(context),
    );
  }

  _body(context) {
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
            AppButton(
              "Login",
              onPressed: () {
                _onClickLogin(context);
              },
            )
          ],
        ),
      ),
    );
  }

  _onClickLogin(context) async {
    if (_formKey.currentState.validate()) {
      Result ok = await LoginApi.login(_tLogin.text, _tSenha.text);

      if (ok.status == Status.SUCCESS) {
        push(context, HomPage());
      }else{
        confirmAlert(context, ok.message);
      }
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
}

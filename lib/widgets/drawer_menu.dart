import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text("Allyson"),
                accountEmail: Text("allyson@gmail.com"),
                currentAccountPicture:(CircleAvatar(
                  backgroundImage:NetworkImage("https://scontent.fsdu7-1.fna.fbcdn.net/v/t1.0-9/s960x960/76776514_2477988992451656_4946677473057177600_o.jpg?_nc_cat=107&_nc_eui2=AeE_z_fDjC3J20sq_aFYDkZUTRbj4RlZw7zUf8vdtqbj3nXV6SjEGgM7nWr5HSsId2xfkhc_8fS7zWqR807Ojj0ps56LfLM2-vqDW2TQheds0w&_nc_ohc=gqK-cU8qxFAAQlZhTMQ_59I6y3-BEWu38FsKPM-c786v-lbbj1lN212fw&_nc_ht=scontent.fsdu7-1.fna&oh=762be39130f302c57789f67961b34fb5&oe=5EAACAA3"),
                ))
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("Seus favoritos"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("Mais informações"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                _onClickLogout(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

_onClickLogout(BuildContext context) {

  Navigator.pop(context);
  push(context, LoginPage(), replace: true);
}


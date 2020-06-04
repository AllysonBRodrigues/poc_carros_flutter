import 'package:carros/network/firebase_service.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<User>(
              future: User.get(),
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? _header(snapshot.data)
                    : Container();
              },
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

  UserAccountsDrawerHeader _header(User user) {
    return UserAccountsDrawerHeader(
        accountName: Text(user.nome ?? "Usuario do Firebase"),
        accountEmail: Text(user.email),
        currentAccountPicture: (CircleAvatar(
          backgroundImage: NetworkImage(user.urlFoto ?? "https://www.dovercourt.org/wp-content/uploads/2019/11/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.jpg"),
        )));
  }
}

_onClickLogout(BuildContext context) {
  User.clear();
  FirebaseService().logout();
  Navigator.pop(context);
  push(context, LoginPage(), replace: true);
}

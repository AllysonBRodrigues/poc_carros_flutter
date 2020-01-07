class User {
  String name;
  String login;
  String email;
  String token;
  List<String> roles;

  User.fromJson(Map<String, dynamic> map)
      : login = map["login"],
        name = map["name"],
        email = map["email"],
        token = map["token"],
        roles = map["roles"] != null
            ? map["roles"].map<String>((role) => role.toString()).toList()
            : null;

  @override
  String toString() {
    return 'User{name: $name, login: $login, email: $email, token: $token, roles: $roles}';
  }
}

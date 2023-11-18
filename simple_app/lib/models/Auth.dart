class Auth {
  int? login;
  String? password;
  String? token;

  Auth({this.login, this.password, this.token});

  Auth.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }
}

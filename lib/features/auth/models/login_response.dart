import 'package:limcad/resources/api/from_json.dart';

class LoginResponse implements FromJson<LoginResponse> {
  String? refreshToken;
  String? token;
  User? user;

  LoginResponse({this.refreshToken, this.token, this.user});

  @override
  LoginResponse fromJson(Map<String, dynamic> json) {
    refreshToken = json['refreshToken'];
    token = json['token'];
    user = json['user'] != null ? User().fromJson(json['user']) : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refreshToken'] = refreshToken;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User implements FromJson<User> {
  String? email;
  int? id;
  String? name;
  String? phoneNumber;
  String? userType;
  bool? verified;

  User({this.email, this.id, this.name, this.phoneNumber, this.userType, this.verified});

  @override
  User fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    userType = json['userType'];
    verified = json['verified'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['userType'] = userType;
    data['verified'] = verified;
    return data;
  }

}

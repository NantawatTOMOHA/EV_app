import'dart:convert';
LoginResponseModel loginResponseJson(String str)=>
  LoginResponseModel.fromJson(json.decode(str));
class LoginResponseModel {
  LoginResponseModel({
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
    required this.accessToken,
  });
  late final String username;
  late final String email;
  late final bool isAdmin;
  late final String avatar;
  late final String createdAt;
  late final String updatedAt;
  late final String accessToken;
  
  LoginResponseModel.fromJson(Map<String, dynamic> json){
    username = json['username'];
    email = json['email'];
    isAdmin = json['isAdmin'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['isAdmin'] = isAdmin;
    _data['avatar'] = avatar;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['accessToken'] = accessToken;
    return _data;
  }
}
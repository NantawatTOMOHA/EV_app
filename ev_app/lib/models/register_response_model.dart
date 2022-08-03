import'dart:convert';
RegisterResponseModel registerResponseModel(String str)=>
  RegisterResponseModel.fromJson(json.decode(str));
class RegisterResponseModel {
  RegisterResponseModel({
    required this.username,
    required this.email,
    required this.password,
    required this.isAdmin,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String username;
  late final String email;
  late final String password;
  late final bool isAdmin;
  late final String avatar;
  late final String createdAt;
  late final String updatedAt;
  
  RegisterResponseModel.fromJson(Map<String, dynamic> json){
    username = json['username']!=null  ?  username=json['username']:null;
    email = json['email'];
    password = json['password'];
    isAdmin = json['isAdmin'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['password'] = password;
    _data['isAdmin'] = isAdmin;
    _data['avatar'] = avatar;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}
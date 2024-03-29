import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_flutter/models/login_request_model.dart';
import 'package:my_flutter/config.dart';
import 'package:my_flutter/models/login_response_model.dart';
import 'package:my_flutter/models/register_response_model.dart';
import 'package:my_flutter/models/register_request_model.dart';
import 'package:my_flutter/services/shared_service.dart';


class APIService{
  static var client = http.Client();
  
  static Future<bool> login(
    LoginRequestModel model
    ) async{
    Map<String,String> requestHeaders ={
      'Content-Type' : 'application/json',
      'token':'we'
    };

    var url = Uri.https(Config.apiURL, Config.loginAPI);

    var response = await client.post(url, 
    headers: requestHeaders,
    body: jsonEncode(model.toJson()),
    
    );

    if(response.statusCode==200){
      //shared
      await SharedService.SetloginDetails(loginResponseJson(response.body));
      return true;
    }else{
      return false;
    }
  }


  static Future<RegisterResponseModel> register(
    RegisterRequestModel model
    ) async{
    Map<String,String> requestHeaders ={
      'Content-Type' : 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(url, 
    headers: requestHeaders,
    body: jsonEncode(model.toJson()),
    
    );

   return registerResponseModel(response.body);
  }
}
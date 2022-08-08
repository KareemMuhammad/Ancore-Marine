import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shop_app/models/user.dart';
import '../models/Cart.dart';
import '../services/user_service.dart';

class UserRepository{
  final UserHttpService _userHttpService = UserHttpService();

  Future<UserHolder> loginResponse(String email,String password)async{
   Response response = await _userHttpService.loginService(email, password);
   if(response.statusCode == 200){
     if(jsonDecode(response.body)['user'] != null) {
       return UserHolder(
           user: User.fromJson(jsonDecode(response.body)['user']),
           message: jsonDecode(response.body)['message']);
     }else{
       return UserHolder(
           user: User(),
           message: jsonDecode(response.body)['message']);
     }
   }else{
     return UserHolder(user: User(),
         message: 'Error in server');
   }
  }

  Future<UserHolder> signUpResponse(String name, String email,
      String phone, String password,
      String address,String confirm)async{

    Response response = await _userHttpService.
    signUpService(name,email,phone,
    password,address,confirm);
    debugPrint(response.statusCode.toString());

    if(response.statusCode == 200){
      if(jsonDecode(response.body)['user'] != null) {
        return UserHolder(
            user: User.fromJson(jsonDecode(response.body)['user']),
            message: jsonDecode(response.body)['message']);
      }else{
        return UserHolder(
            user: User(),
            message: jsonDecode(response.body)['message']);
      }
    }else{
      return UserHolder(user: User(),
          message: 'Error in server');
    }
  }

  Future<bool> logOutResponse(String token)async{
   Response response = await _userHttpService.logoutService(token);
   if(response.statusCode == 200){
     debugPrint(jsonDecode(response.body).toString());
     return jsonDecode(response.body)['status'];
   }else{
     return false;
   }
  }

  Future<UserHolder> getUser(String token)async{
    Response response = await _userHttpService.getUserByID(token);
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['user'] != null) {
        return UserHolder(
            user: User.fromJson(jsonDecode(response.body)['user']),
            message: jsonDecode(response.body)['message']);
      }else{
        return UserHolder(
            user: User(),
            message: jsonDecode(response.body)['message']);
      }
    }else{
      return UserHolder(user: User(),
          message: 'Error in server');
    }
  }

  Future<CartHolder> getMyPurchasesResponse(String token)async{
    Response response = await _userHttpService.getUserPurchases(token);
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['orders'] != null) {
        debugPrint(jsonDecode(response.body).toString());
        List cat = jsonDecode(response.body)['orders'];
        return CartHolder(
            orders: cat.map((e) => Orders.fromJson(e)).toList(),
            message: jsonDecode(response.body)['message']);
      }else{
        return CartHolder(
            orders: [],
            message: jsonDecode(response.body)['message']);
      }
    }else{
      return CartHolder(
          orders: [],
          message: 'Error in server');
    }
  }

}
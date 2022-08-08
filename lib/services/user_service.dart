import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'base_api.dart';

class UserHttpService extends BaseAPI{

  Future<Response> loginService(String email,String password)async{
    try {

      Response response = await post(
          Uri.parse(super.loginPath + 'email=$email&' + 'password=$password&')
          ,headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> signUpService(String name, String email,
      String phone, String password,String address,String confirmPass) async {
    try {

      Response response = await post(Uri.parse(
          super.registrationPath + 'name=$name&' + 'email=$email&' +
              'address=$address&' + 'mobile=$phone&' + 'password=$password&'
       + 'password_confirmation=$confirmPass'));
      debugPrint(jsonDecode(response.body).toString());
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> logoutService(String token)async{
    try {

      Response response = await post(Uri.parse(super.logoutPath +
          'auth_token=$token'), headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> resetPasswordService(String email)async{
    try {

      Response response = await post(Uri.parse(super.resetPassword +
          'email=$email'), headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> updateUserDetails(String name, String email,
      String token, String phone,
      String password,String confirmPass)async{
    try {

      Response response = await post(Uri.parse(super.updateUserPath +
          'auth_token=$token&'+
          'name=$name&' + 'email=$email&' + 'phone=$phone&'
          + 'password=$password&' + 'password_confirmation=$confirmPass'),
          headers: super.headers);

      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> getUserByID(String id)async{
    try {

      Response response = await post(Uri.parse(super.getUserById +
          'auth_token=$id'),
          headers: super.headers);

      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> getUserPurchases(String token)async{
    try {

      Response response = await post(Uri.parse(super.getPurchases +
          'auth_token=$token'),
          headers: super.headers);

      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> deleteAccount(String token)async{
    try {

      Response response = await post(Uri.parse(super.deleteAccPath +
          'auth_token=$token'),
          headers: super.headers);

      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

}
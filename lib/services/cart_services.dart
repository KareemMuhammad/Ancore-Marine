import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shop_app/services/base_api.dart';

class CartServices extends BaseAPI{

  Future<Response> fetchCartServices(String token)async{
    try {
      Response response = await post(Uri.parse(super.cartDataPath + 'auth_token=$token'));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> addToCartServices(String token,int productId,int count,int price)async{
    try {
      Response response = await post(Uri.parse(super.addToCartPath +
          'auth_token=$token&' + 'productId=$productId&' +

          'count=$count&' + 'price=$price'));
      debugPrint(jsonDecode(response.body).toString());
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> removeFromCartServices(String token,int productId)async{
    try {
      Response response = await post(Uri.parse(super.removeFromCartPath +
          'auth_token=$token&' + 'productId=$productId'));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

}
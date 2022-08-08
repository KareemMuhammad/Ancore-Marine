import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/services/cart_services.dart';

class CartRepo{
  final CartServices _cartServices = CartServices();
   Future<CartHolder> getCartResponse(String token)async{
    Response response = await _cartServices.fetchCartServices(token);
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['orders'] != null) {
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
      return CartHolder(orders: [],
          message: 'Error in server');
    }
   }

   Future<String> addToCartResponse(String token,int productId,int count,int price)async{
    Response response = await _cartServices.addToCartServices(token, productId, count, price);
    if(response.statusCode == 200){
      var msg = jsonDecode(response.body)['message'];
      return msg;
    }else{
      return 'Server error';
    }
   }

  Future<bool> removeFromCartResponse(String token,int productId)async{
    Response response = await _cartServices.removeFromCartServices(token, productId);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}
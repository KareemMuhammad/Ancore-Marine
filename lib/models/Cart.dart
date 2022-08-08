
import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/product_model.dart';

class CartHolder {
  bool? status;
  String? successNumber;
  String? message;
  List<Orders>? orders;

  CartHolder({this.status, this.successNumber, this.message, this.orders});

  CartHolder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successNumber = json['successNumber'];
    message = json['message'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }else{
      orders = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['successNumber'] = this.successNumber;
    data['message'] = this.message;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  double getLiveSum(){
    var sum = 0.0;
    if(orders!.isNotEmpty) {
      for (var i = 0; i < orders!.length; i++) {
        sum += orders![i].product!.getOfferPrice(orders![i].product!.offer!);
      }
    }
    return sum;
  }
}

class Orders {
  int? id;
  int? userId;
  int? productId;
  int? count;
  CartProduct? product;
  Images? image;
  String? date;

  Orders(
      {this.id,
        this.userId,
        this.productId,
        this.count,
        this.product,
        this.image,
      this.date});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    count = json['count'];
    date = json['created_at'];
    product =
    json['product'] != null ? new CartProduct.fromJson(json['product']) : null;
    image = json['image'] != null ? new Images.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['count'] = this.count;
    data['created_at'] = this.date;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class CartProduct {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;
  String? offer;

  CartProduct({this.id, this.nameAr, this.nameEn, this.price, this.offer});

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
    offer = json['offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['price'] = this.price;
    data['offer'] = this.offer;
    return data;
  }

  double getOfferPrice(String offer){
    return double.parse(price!) - (double.parse(price!) * (double.parse(offer)/100));
  }

  getOffer(String offer){
    return (double.parse(price!) * double.parse(offer)/100);
  }
}

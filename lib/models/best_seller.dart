import 'package:shop_app/models/product_model.dart';

class BestSellerHolder {
  bool? status;
  String? successNumber;
  String? message;
  List<BestSeller>? products;

  BestSellerHolder(
      {this.status, this.successNumber, this.message, this.products});

  BestSellerHolder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successNumber = json['successNumber'];
    message = json['message'];
    if (json['products'] != null) {
      products = <BestSeller>[];
      json['products'].forEach((v) {
        products!.add(new BestSeller.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['successNumber'] = this.successNumber;
    data['message'] = this.message;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BestSeller {
  int? productId;
  int? count;
  Products? product;
  List<Images>? images;

  BestSeller({this.productId, this.count, this.product, this.images});

  BestSeller.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    count = json['count'];
    product = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }else{
      images = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['count'] = this.count;
    if (this.product != null) {
      data['products'] = this.product!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
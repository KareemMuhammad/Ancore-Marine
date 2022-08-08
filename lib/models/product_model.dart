import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/helper/helpers.dart';
part 'product_model.g.dart';

class ProductHolder {
  bool? status;
  String? errorNumber;
  String? message;
  List<Products>? products;

  ProductHolder({this.status, this.errorNumber, this.message, this.products});

  ProductHolder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errorNumber'];
    message = json['message'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errorNumber'] = this.errorNumber;
    data['message'] = this.message;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


@HiveType(typeId: 1)
class Products extends HiveObject{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? nameAr;
  @HiveField(2)
  String? nameEn;
  @HiveField(3)
  String? descriptionAr;
  @HiveField(4)
  String? descriptionEn;
  @HiveField(5)
  String? price;
  @HiveField(6)
  int? stock;
  @HiveField(7)
  double? offer;
  @HiveField(8)
  int? count;
  @HiveField(9)
  int? categoryId;
  @HiveField(10)
  List<Images>? images;

  Products(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.descriptionAr,
        this.descriptionEn,
        this.price,
        this.stock,
        this.offer,
        this.count,
        this.categoryId,
        this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    price = json['price'];
    stock = json['stock'];
    offer = getOffer(json['offer']) ?? 0;
    count = json['count'] ?? 0;

    categoryId = json['category_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }else{
      images = <Images>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['offer'] = this.offer;
    data['count'] = this.count;
    data['category_id'] = this.categoryId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  double getOfferPrice(String offer){
    return double.parse(price!) - (double.parse(price!) * (double.parse(offer)/100));
  }

  getOffer(String offer){
    return (double.parse(price!) * double.parse(offer)/100);
  }
}

@HiveType(typeId: 2)
class Images extends HiveObject{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? productId;

  Images({this.id, this.name, this.productId});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = Utils.assetsProductUtil + json['name'];
    productId = json['product_id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    return data;
  }
}
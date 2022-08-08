import 'package:shop_app/helper/helpers.dart';

class CategoriesHolder {
  bool? status;
  String? errorNumber;
  String? message;
  List<Categories>? categories;

  CategoriesHolder({this.status, this.errorNumber, this.message, this.categories});

  CategoriesHolder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errorNumber'];
    message = json['message'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errorNumber'] = this.errorNumber;
    data['message'] = this.message;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;

  Categories(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.image,
      });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    image = Utils.assetsCategoryUtil + json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['image'] = this.image;
    return data;
  }
}
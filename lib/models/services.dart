import 'package:shop_app/helper/helpers.dart';

class MaintenanceServicesHolder {
  bool? status;
  String? successNumber;
  String? message;
  List<Services>? services;

  MaintenanceServicesHolder(
      {this.status, this.successNumber, this.message, this.services});

  MaintenanceServicesHolder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successNumber = json['successNumber'];
    message = json['message'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }else{
      services = <Services>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['successNumber'] = this.successNumber;
    data['message'] = this.message;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  int? price;
  String? image;

  Services(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.descriptionAr,
        this.descriptionEn,
        this.price,
        this.image,
        });

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    price = json['price'];
    image = Utils.assetsServiceUtil + json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
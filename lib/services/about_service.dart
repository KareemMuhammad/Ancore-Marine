import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/about_model.dart';
import 'base_api.dart';

class AboutService extends BaseAPI{

  Future<List<AboutModel>> getAboutLanguage(String local)async{
    try {
     Response response = await post(Uri.parse(super.aboutPath + 'lang=' + local));
     debugPrint(jsonDecode(response.body).toString());
     List<AboutModel> localList = [];
     if(jsonDecode(response.body)['about'] != null) {
       final List list = jsonDecode(response.body)['about'];

       local == 'en' ?
       localList = list.map((data) => AboutModel.fromJsonEn(data)).toList() :
       local == 'ar' ?
       localList = list.map((data) => AboutModel.fromJsonAr(data)).toList() :
       local == 'ur' ?
       localList = list.map((data) => AboutModel.fromJsonUr(data)).toList() :
       localList = list.map((data) => AboutModel.fromJsonFil(data)).toList();
     }
     return localList;
    }catch(e){
      debugPrint(e.toString());
      return const [];
    }
  }

  // Future<Response> sendContactService(String name,String email,
  //     String subject,String message)async{
  //   try {
  //
  //     Response response = await post(Uri.parse(super.paymentCheckPath +
  //         'name=$name&' + 'email=$email&' + 'subject=$subject&' +
  //         'message=$message'), headers: super.headers);
  //     return response;
  //   }catch(e){
  //     debugPrint(e.toString());
  //     return Response('', 404);
  //   }
  // }
}
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/services/categories_service.dart';

class CategoriesRepo{
  final CategoriesService _categoriesService = CategoriesService();

  Future<CategoriesHolder> getCategoriesResponse()async{
   Response response = await _categoriesService.fetchCategories();
   if(response.statusCode == 200){
     if(jsonDecode(response.body)['categories'] != null) {
       List cat = jsonDecode(response.body)['categories'];
       return CategoriesHolder(
           categories: cat.map((e) => Categories.fromJson(e)).toList(),
           message: jsonDecode(response.body)['message']);
     }else{
       return CategoriesHolder(
           categories: [],
           message: jsonDecode(response.body)['message']);
     }
   }else{
     return CategoriesHolder(categories: [],
         message: 'Error in server');
   }
  }

}
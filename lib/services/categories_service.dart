import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shop_app/services/base_api.dart';

class CategoriesService extends BaseAPI{

  Future fetchCategories()async{
    try {
      Response response = await post(Uri.parse(super.getCategories));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
 }
}
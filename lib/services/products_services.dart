import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shop_app/services/base_api.dart';

class ProductService extends BaseAPI {

  Future<Response> fetchProductsByCategory(int categoryId)async{
    try {
      Response response = await post(Uri.parse(super.productsByCategoryPath +
          'category_id=$categoryId'));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> fetchBestSelling()async{
    try {
      Response response = await post(Uri.parse(super.bestSellerPath));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }
  Future<Response> fetchOffersProducts()async{
    try {
      Response response = await post(Uri.parse(super.offersPath));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> getProductById(int productId)async{
    try {
      Response response = await post(Uri.parse(super.productPath +
          'id=$productId'));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }
}
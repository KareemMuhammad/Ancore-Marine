import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/best_seller.dart';
import 'package:shop_app/services/products_services.dart';

class ProductsRepo{
  final ProductService _productService = ProductService();

  Future<ProductHolder> getProductByCategoryResponse(int categoryId)async{
    Response response = await _productService.fetchProductsByCategory(categoryId);
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['products'] != null) {
        List cat = jsonDecode(response.body)['products'];
        debugPrint(cat.length.toString());
        return ProductHolder(
            products: cat.map((e) => Products.fromJson(e)).toList(),
            message: jsonDecode(response.body)['message']);
      }else{
        return ProductHolder(
            products: [],
            message: jsonDecode(response.body)['message']);
      }
    }else{
      return ProductHolder(products: [],
          message: 'Error in server');
    }
  }


  Future<BestSellerHolder> getBestSellingResponse()async{
    Response response = await _productService.fetchBestSelling();
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['products'] != null) {
        List cat = jsonDecode(response.body)['products'];
        return BestSellerHolder(
            products: cat.map((e) => BestSeller.fromJson(e)).toList(),
            message: jsonDecode(response.body)['message']);
      }else{
        return BestSellerHolder(
            products: [],
            message: jsonDecode(response.body)['message']);
      }
    }else{
      return BestSellerHolder(products: [],
          message: 'Error in server');
    }
  }

  Future<ProductHolder> getOffersResponse()async{
    Response response = await _productService.fetchOffersProducts();
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['products'] != null) {
        List cat = jsonDecode(response.body)['products'];
        return ProductHolder(
            products: cat.map((e) => Products.fromJson(e)).toList(),
            message: jsonDecode(response.body)['message']);
      }else{
        return ProductHolder(
            products: [],
            message: jsonDecode(response.body)['message']);
      }
    }else{
      return ProductHolder(products: [],
          message: 'Error in server');
    }
  }

  Future<Products> getProduct(int id)async{
    Response response = await _productService.getProductById(id);
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['product'] != null){
        return Products.fromJson(jsonDecode(response.body)['product']);
      }else{
        return Products();
      }
    }else{
      return Products();
    }
  }

}
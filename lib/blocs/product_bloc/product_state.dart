import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/product_model.dart';

@immutable
abstract class ProductsState{}

class ProductsInitial extends ProductsState{}

class ProductsLoading extends ProductsState{}

class ProductsFailed extends ProductsState{}

class ProductsSuccessful extends ProductsState{
  final List<Products> products;

  ProductsSuccessful(this.products);
}
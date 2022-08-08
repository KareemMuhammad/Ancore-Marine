import 'package:flutter/material.dart';
import 'package:shop_app/models/category.dart';

@immutable
abstract class CategoriesState{}

class CategoriesInitial extends CategoriesState{}

class CategoriesLoading extends CategoriesState{}

class CategoriesFailed extends CategoriesState{}

class CategoriesSuccessful extends CategoriesState{
  final List<Categories> categories;

  CategoriesSuccessful(this.categories);
}
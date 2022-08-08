import 'package:flutter/material.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/screens/products/components/body.dart';

import '../../helper/language_delegate.dart';

class ProductsScreen extends StatelessWidget {
  final Categories category;
  const ProductsScreen({Key? key, required this.category}) : super(key: key);

  static String routeName = "/products";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(   AppLocale.of(context).currentCode == 'en' ?
          category.nameEn! : category.nameAr!,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Body(categoryId: category.id!,),
    );
  }
}

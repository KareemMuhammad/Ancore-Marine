import 'package:flutter/material.dart';
import '../../helper/language_delegate.dart';
import '../../models/product_model.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: agrs.product.count!.toDouble(),
          name: AppLocale.of(context).currentCode == 'ar' ?
              agrs.product.nameAr! :agrs.product.nameEn!,
          product: agrs.product..images = agrs.images,),
      ),
      body: Body(product: agrs.product,images: agrs.images,),
    );
  }
}

class ProductDetailsArguments {
  final Products product;
  final List<Images> images;

  ProductDetailsArguments({required this.images, required this.product});
}

import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/best_seller.dart';
import 'package:shop_app/theme.dart';
import '../../../helper/helpers.dart';
import '../../../repositories/products_repo.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class BestSelling extends StatefulWidget {
  @override
  State<BestSelling> createState() => _BestSellingState();
}

class _BestSellingState extends State<BestSelling> {
  List<BestSeller>? products = [];
  final ProductsRepo _productsRepo = ProductsRepo();

  @override
  void initState() {
    Future.microtask(() async{
      BestSellerHolder holder = await _productsRepo.getBestSellingResponse();
      products = holder.products;
      if(mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "${Utils.getTranslatedText(context, 'best_selling')}", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(15)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products!.isNotEmpty?
            List.generate(
                products!.length,
                (index) {
                    return ProductCard(bestSeller: products![index]);
                },
              ) :  List.generate(4,
                  (index) {
                  return loadProductsShimmer();
              },
            ),
          ),
        )
      ],
    );
  }
}

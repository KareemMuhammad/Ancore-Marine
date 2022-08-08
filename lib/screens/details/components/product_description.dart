import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/details/components/color_dots.dart';
import '../../../constants.dart';
import '../../../helper/language_delegate.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Products product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    var counter = product.count! - product.count! + 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            children: [
              product.offer! > 0?
              Text(
                "\$${product.getOfferPrice(product.offer!.toString()).toInt()} ",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ) : const SizedBox(),
              Text(
                "\$${product.price}",
                style: TextStyle(
                    fontSize:  getProportionateScreenWidth(product.offer! > 0? 13 : 15),
                    fontWeight: product.offer! > 0? FontWeight.w300 : FontWeight.w600,
                    color: kPrimaryColor,
                    decoration: product.offer! > 0?
                    TextDecoration.lineThrough : TextDecoration.none
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(25),
            right: getProportionateScreenWidth(25),
            top: getProportionateScreenWidth(20),
          ),
          child: Text(
            AppLocale.of(context).currentCode == 'en' ?
            product.descriptionEn! : product.descriptionAr!,
            maxLines: 3,
            style: TextStyle(
              height: 1,
              color: Colors.grey[700],
              fontSize: getProportionateScreenWidth(11.5),
            ),
          ),
        ),
        CounterWidget(product: product, count: counter,)
      ],
    );
  }
}

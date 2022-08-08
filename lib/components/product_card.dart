import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/models/best_seller.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import '../constants.dart';
import '../helper/helpers.dart';
import '../helper/language_delegate.dart';
import '../models/favorite.dart';
import '../models/product_model.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.bestSeller,
  }) : super(key: key);

  final double width, aspectRetio;
  final BestSeller bestSeller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: bestSeller.product!, images: bestSeller.images!,),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Container(
               height: getProportionateScreenWidth(100),
                  width: getProportionateScreenWidth(150),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: splashColor.withOpacity(0.3),
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.75))
                    ]
                  ),
                  child: Hero(
                    tag: bestSeller.productId.toString(),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                            imageUrl: bestSeller.images![0].name!,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                AppLocale.of(context).currentCode == 'en' ?
                bestSeller.product!.nameEn! : bestSeller.product!.nameAr!,
                style: TextStyle(fontSize: getProportionateScreenWidth(12.5),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      bestSeller.product!.offer! > 0?
                      Text(
                        "\$${bestSeller.product!.getOfferPrice(bestSeller.product!.offer!.toString()).toInt()} ",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(12.5),
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ) : const SizedBox(),
                      Text(
                        "\$${bestSeller.product!.price}",
                        style: TextStyle(
                            fontSize:  getProportionateScreenWidth(bestSeller.product!.offer! > 0? 11 : 12.5),
                            fontWeight: bestSeller.product!.offer! > 0? FontWeight.w300 : FontWeight.w600,
                            color: kPrimaryColor,
                            decoration: bestSeller.product!.offer! > 0?
                            TextDecoration.lineThrough : TextDecoration.none
                        ),
                      ),
                    ],
                  ),
                  ValueListenableBuilder<Box<Favorite>>(
                      valueListenable: Utils.getFavorites().listenable(),
                      builder: (context,box,_) {
                        final favorites = box.values.toList().cast<Favorite>();
                        var isWish = favorites.where((element) =>
                        element.product!.id == bestSeller.product!.id).isNotEmpty;
                      return InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () async{
                          if(!isWish) {
                            debugPrint('false state');
                            bestSeller.product!.images = bestSeller.images;
                            await addFavorite(bestSeller.product!);
                          }else{
                            debugPrint('true state');
                            var fav = favorites.where((element) =>
                            element.product!.id == bestSeller.product!.id).first;
                            await removeFavorite(fav);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                          height: getProportionateScreenWidth(28),
                          width: getProportionateScreenWidth(28),
                          decoration: BoxDecoration(
                            color: isWish
                                ? kPrimaryColor.withOpacity(0.15)
                                : kSecondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/Heart Icon_2.svg",
                            color: isWish
                                ? Color(0xFFFF4848)
                                : Color(0xFFDBDEE4),
                          ),
                        ),
                      );
                    }
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addFavorite(
      Products product,
      ) async {
    final favourite = Favorite()..product = product;

    var box = Utils.getFavorites();
    box.add(favourite);

  }

  Future removeFavorite(
      Favorite favorite,
      ) async {
    favorite.delete();
  }
}

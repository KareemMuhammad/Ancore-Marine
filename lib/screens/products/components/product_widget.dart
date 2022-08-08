import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../constants.dart';
import '../../../helper/helpers.dart';
import '../../../helper/language_delegate.dart';
import '../../../models/favorite.dart';
import '../../../models/product_model.dart';
import '../../../size_config.dart';
import '../../details/details_screen.dart';

class ProductWidget extends StatelessWidget {
  final Products product;
  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: product, images: product.images!,),
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
                  tag: product.id.toString(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: product.images![0].name!,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocale.of(context).currentCode == 'en' ?
                product.nameEn! : product.nameAr!,
                style: TextStyle(fontSize: getProportionateScreenWidth(12.5),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      product.offer! > 0?
                      Text(
                        "\$${product.getOfferPrice(product.offer!.toString()).toInt()} ",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(12.5),
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ) : const SizedBox(),
                      Text(
                        "\$${product.price}",
                        style: TextStyle(
                            fontSize:  getProportionateScreenWidth(product.offer! > 0? 11 : 12.5),
                            fontWeight: product.offer! > 0? FontWeight.w300 : FontWeight.w600,
                            color: kPrimaryColor,
                            decoration: product.offer! > 0?
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
                        element.product!.id == product.id).isNotEmpty;
                        return InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () async{
                            if(!isWish) {
                              debugPrint('false state');
                              await addFavorite(product);
                            }else{
                              debugPrint('true state');
                              var fav = favorites.where((element) =>
                              element.product!.id == product.id).first;
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

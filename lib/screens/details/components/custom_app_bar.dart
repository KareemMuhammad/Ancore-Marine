import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/helper/helpers.dart';
import '../../../models/favorite.dart';
import '../../../models/product_model.dart';
import '../../../size_config.dart';

class CustomAppBar extends StatelessWidget {
  final double rating;
  final String name;
  final Products product;

  CustomAppBar({required this.rating, required this.name, required this.product});

  @override
  Widget build(BuildContext context) {
    debugPrint(product.images.toString());
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: kPrimaryColor,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.headline6,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                width: getProportionateScreenWidth(64),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: ValueListenableBuilder<Box<Favorite>>(
                  valueListenable: Utils.getFavorites().listenable(),
                  builder: (context,box,_) {
                    final favorites = box.values.toList().cast<Favorite>();
                    var isWish = favorites.where((element) =>
                    element.product!.id == product.id).isNotEmpty;
                    return GestureDetector(
                      onTap: ()async{
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
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color:
                        isWish ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                        height: getProportionateScreenWidth(16),
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
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

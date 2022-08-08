import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/helper/helpers.dart';
import 'package:shop_app/screens/wishlist/components/wish_body.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../../models/favorite.dart';
import '../../size_config.dart';
import '../../theme.dart';

class WishlistScreen extends StatelessWidget {
  static String routeName = "/wish";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ValueListenableBuilder<Box<Favorite>>(
          valueListenable: Utils.getFavorites().listenable(),
        builder: (context,box,_)  {
          final favorites = box.values.toList().cast<Favorite>();
          return WishBody(wishList: favorites,);
        }
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          Text(
            "${Utils.getTranslatedText(context, 'wishlist')}",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

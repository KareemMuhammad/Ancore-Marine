import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/blocs/cart_bloc/cart_cubit.dart';
import 'package:shop_app/blocs/cart_bloc/cart_state.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/wishlist/wishlist_screen.dart';
import '../constants.dart';
import '../enums.dart';
import '../screens/cart/cart_screen.dart';
import '../size_config.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical! * 0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == widget.selectedMenu
                      ? kPrimaryColor
                      : Colors.grey[600],
                ),
                iconSize: SizeConfig.blockSizeVertical! * 3,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, HomeScreen.routeName),
              ),
              IconButton(
                icon: Icon(Icons.favorite_outline),
                iconSize: SizeConfig.blockSizeVertical! * 3,
                color: MenuState.favourite == widget.selectedMenu
                    ? kPrimaryColor
                    : Colors.grey[500],
                onPressed: () {
                  Navigator.pushReplacementNamed(context, WishlistScreen.routeName);
                },
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 5),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart_outlined),
                      iconSize: SizeConfig.blockSizeVertical! * 3,
                      color: MenuState.cart == widget.selectedMenu
                          ? kPrimaryColor
                          : Colors.grey[500],
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, CartScreen.routeName);
                      },
                    ),
                  ),
                  BlocBuilder<CartCubit,CartState>(
                    builder: (context,state) {
                      return state is CartSuccessful ?
                      Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.red,
                              child: Text(
                                '${state.cartHolder.orders!.length}',
                                style: TextStyle(color: Colors.white),)))
                      : const SizedBox();
                    }
                  )
                ],
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == widget.selectedMenu
                      ? kPrimaryColor
                      : Colors.grey[600],
                ),
                iconSize: SizeConfig.blockSizeVertical! * 3,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }
}

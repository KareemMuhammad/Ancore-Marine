import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/Cart.dart';

import '../../../blocs/cart_bloc/cart_cubit.dart';
import '../../../blocs/login_bloc/login_cubit.dart';
import '../../../constants.dart';
import '../../../helper/language_delegate.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Orders cart;

  @override
  Widget build(BuildContext context) {
    debugPrint(cart.count!.toString() + '${cart.product!.offer}');
    final cartBloc = BlocProvider.of<CartCubit>(context);
    return ListTile(
      title: Text(   AppLocale.of(context).currentCode == 'en' ?
        cart.product!.nameEn! : cart.product!.nameAr!,
        style: TextStyle(color: Colors.black, fontSize: 16),
        maxLines: 2,
      ),
      subtitle: Row(
        children: [
          int.parse(cart.product!.offer!) > 0?
          Text(
            "\$${cart.product!.getOfferPrice(cart.product!.offer!).toInt()} ",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12.5),
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ) : const SizedBox(),
          Text(
            "\$${cart.product!.price}",
            style: TextStyle(
                fontSize:  getProportionateScreenWidth(int.parse(cart.product!.offer!) > 0? 11 : 12.5),
                fontWeight: int.parse(cart.product!.offer!) > 0? FontWeight.w300 : FontWeight.w600,
                color: kPrimaryColor,
                decoration: int.parse(cart.product!.offer!) > 0?
                TextDecoration.lineThrough : TextDecoration.none
            ),
          ),
        ],
      ),
      leading:  Container(
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
        child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: cart.image!.name!,
                fit: BoxFit.cover,
              )),
      ),
      trailing: GestureDetector(
          onTap: ()async{
            cartBloc.removeFromCart(BlocProvider.of<LoginCubit>
              (context).getToken, cart.product!.id!);
          },
          child: SvgPicture.asset('assets/icons/Trash.svg')),
    );
  }
}

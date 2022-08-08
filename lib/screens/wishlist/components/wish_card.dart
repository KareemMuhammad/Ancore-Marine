import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/repositories/products_repo.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import '../../../blocs/cart_bloc/cart_cubit.dart';
import '../../../blocs/login_bloc/login_cubit.dart';
import '../../../blocs/product_bloc/product_cubit.dart';
import '../../../constants.dart';
import '../../../helper/helpers.dart';
import '../../../helper/language_delegate.dart';
import '../../../models/product_model.dart';
import '../../../size_config.dart';
import '../../sign_in/sign_in_screen.dart';

class WishCard extends StatelessWidget {
  const WishCard({
    Key? key,
    required this.wish,
  }) : super(key: key);

  final Products wish;

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    final productCubit = BlocProvider.of<ProductsCubit>(context);
    final cartBloc = BlocProvider.of<CartCubit>(context);
    return GestureDetector(
      onTap: ()async{
       Products product = await ProductsRepo().getProduct(wish.id!);
       if(product.id != null) {
         Navigator.pushNamed(context, DetailsScreen.routeName,
           arguments: ProductDetailsArguments(
             product: product, images: product.images!,),);
       }
      },
      child: ListTile(
          title: Text(   AppLocale.of(context).currentCode == 'en' ?
            wish.nameEn! : wish.nameAr!,
            style: TextStyle(color: Colors.black, fontSize: 16),
            maxLines: 2,
          ),
          subtitle: Row(
            children: [
              wish.offer! > 0?
              Text(
                "\$${wish.getOfferPrice(wish.offer!.toString()).toInt()} ",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(12.5),
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ) : const SizedBox(),
              Text(
                "\$${wish.price}",
                style: TextStyle(
                    fontSize:  getProportionateScreenWidth( wish.offer! > 0? 11 : 12.5),
                    fontWeight:  wish.offer! > 0? FontWeight.w300 : FontWeight.w600,
                    color: kPrimaryColor,
                    decoration:  wish.offer! > 0?
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
                  imageUrl: wish.images!.first.name!,
                  fit: BoxFit.cover,
                )),
          ),
          trailing: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(splashColor)
              ),
              onPressed: ()async{
                if(loginCubit.currentUser != null) {
                  if(loginCubit.currentToken != null
                      && loginCubit.currentToken!.isNotEmpty) {

                    debugPrint('count =' + productCubit.myCount.toString());
                    String msg =  await cartBloc.addToCart(
                        loginCubit.currentToken!,
                        wish.id!, productCubit.myCount,
                        int.parse(wish.price!)
                    );
                    Utils.showSnack('',msg, context, Colors.black);
                  }else{
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  }
                }else {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                }
              },
              child: Text(
                '${Utils.getTranslatedText(context, 'AddCart')}',
                style: TextStyle(color: Colors.white, fontSize: getProportionateScreenWidth(10)),
              ),
          )
      ),
    );
  }

}
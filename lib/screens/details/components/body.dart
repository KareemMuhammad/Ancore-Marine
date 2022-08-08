import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/product_bloc/product_cubit.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';
import '../../../blocs/cart_bloc/cart_cubit.dart';
import '../../../blocs/login_bloc/login_cubit.dart';
import '../../../helper/helpers.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Products product;
  final List<Images> images;

  const Body({Key? key, required this.product, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final loginCubit = BlocProvider.of<LoginCubit>(context);
   final productCubit = BlocProvider.of<ProductsCubit>(context);
   final cartBloc = BlocProvider.of<CartCubit>(context);
    return ListView(
      children: [
        ProductImages(product: product,images: images,),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                        ),
                        child: DefaultButton(
                          text: "${Utils.getTranslatedText(context, 'AddCart')}",
                          press: () async{
                            if(loginCubit.currentUser != null) {
                              if(loginCubit.currentToken != null
                                  && loginCubit.currentToken!.isNotEmpty) {

                                debugPrint('count =' + productCubit.myCount.toString());
                             String msg =  await cartBloc.addToCart(
                                   loginCubit.currentToken!,
                                   product.id!, productCubit.myCount,
                                   int.parse(product.price!)
                               );
                                Utils.showSnack('',msg, context, Colors.black);
                              }else{
                                Navigator.pushNamed(context, SignInScreen.routeName);
                              }
                            }else {
                              Navigator.pushNamed(context, SignInScreen.routeName);
                            }

                          },
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

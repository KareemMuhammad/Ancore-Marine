import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/cart_bloc/cart_cubit.dart';
import 'package:shop_app/blocs/cart_bloc/cart_state.dart';
import 'package:shop_app/blocs/login_bloc/login_cubit.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../../helper/helpers.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).
    getMyOrders(BlocProvider.of<LoginCubit>(context).getToken);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit,CartState>(
      builder: (context,state) {
        return state is CartSuccessful?
        Scaffold(
          appBar: buildAppBar(context,state.cartHolder.orders!.length),
          body: Column(
            children: [
              Expanded(child: CartBody(ordersList: state.cartHolder.orders!,)),
              CheckoutCard(cartHolder: state.cartHolder,),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.cart),
        ) : state is CartFailed?

        Scaffold(
          appBar: buildAppBar(context,0),
          body: CartBody(ordersList: [],),
          bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.cart),
        ) : Scaffold(
          appBar: buildAppBar(context,0),
          body: Center(
            child: CircularProgressIndicator(color: splashColor,),
          ),
          bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.cart),
        );
      }, listener: (BuildContext context, state) {

    },
    );
  }

  AppBar buildAppBar(BuildContext context,int length) {
    return AppBar(
      toolbarHeight: getProportionateScreenWidth(60),
      title: Column(
        children: [
           SizedBox(height: getProportionateScreenWidth(9),),
          Text(
            "${Utils.getTranslatedText(context, 'cart')}",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "$length ${Utils.getTranslatedText(context, 'items')}",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}

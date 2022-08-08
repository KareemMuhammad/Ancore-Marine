import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Cart.dart';
import '../../../blocs/login_bloc/login_cubit.dart';
import '../../../helper/helpers.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

class CartBody extends StatefulWidget {
  final List<Orders> ordersList;

  const CartBody({Key? key, required this.ordersList}) : super(key: key);
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
 late String token;
  @override
  void initState() {
   token = BlocProvider.of<LoginCubit>(context).getToken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: widget.ordersList.isEmpty?
       Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 0),
          child: Center(child: Text( '${Utils.getTranslatedText(context, 'empty_cart')}', style: TextStyle(
            color: Colors.grey[700],fontSize: getProportionateScreenWidth(15)
          ),)),
        )
      : ListView.builder(
        itemCount: widget.ordersList.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                CartCard(cart: widget.ordersList[index]),
                 Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Divider(color: kSecondaryColor.withOpacity(0.5),),
                 )
              ],
            ),
      ),
    ),
    );
  }
}

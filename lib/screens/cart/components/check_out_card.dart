import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/components/address_dialog.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import '../../../blocs/cart_bloc/cart_cubit.dart';
import '../../../blocs/login_bloc/login_cubit.dart';
import '../../../helper/helpers.dart';
import '../../../services/payment_service.dart';
import '../../../size_config.dart';
import '../../payment/myfatoorah_screen.dart';
import '../../profile/profile_screen.dart';

class CheckoutCard extends StatelessWidget {
  final CartHolder cartHolder;

  const CheckoutCard({
    Key? key, required this.cartHolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
           cartHolder.orders!.isNotEmpty?
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "${Utils.getTranslatedText(context, 'total')}:\n",
                    children: [
                      TextSpan(
                        text: "\$${cartHolder.getLiveSum().toInt()}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "${Utils.getTranslatedText(context, 'checkout')}",
                    press: () async{
                     var address =  await _showMySheet(context);
                     if(address != null) {
                       var res = await PaymentService().payOrder(
                         loginCubit.currentToken!,
                         address,
                       );
                       debugPrint(res.statusCode.toString());
                       debugPrint(jsonDecode(res.body).toString());
                       if(res.statusCode == 200) {
                       var result = await Navigator.push(context,
                             PageTransition(
                                 type: PageTransitionType.rightToLeft,
                                 duration: const Duration(milliseconds: 400),
                                 child: MyFatoorahScreen(url: jsonDecode(res.body)['Data']['InvoiceURL'],)));
                       if(result == 'success'){
                         BlocProvider.of<CartCubit>(context).getMyOrders(loginCubit.getToken);
                         Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
                       }

                       }
                     }
                    },
                  ),
                ),
              ],
            ): SizedBox(),
          ],
        ),
      ),
    );
  }

  Future _showMySheet(BuildContext context) async{
  return await showModalBottomSheet(context: context, builder: (_){
      return AddressDialog();
    },
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
      ),
    );
  }
}

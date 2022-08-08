import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/screens/account/acount_screen.dart';
import 'package:shop_app/screens/purchases/purchases_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import '../../../blocs/login_bloc/login_cubit.dart';
import '../../../components/delete_account_dialog.dart';
import '../../../helper/helpers.dart';
import '../../../services/user_service.dart';
import '../../../size_config.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "${Utils.getTranslatedText(context, 'account')}",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              if(loginCubit.getToken.isNotEmpty){
            Navigator.push(context,
              PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 400),
              child: AccountScreen(user: loginCubit.currentUser,)))
            }else{
              Navigator.of(context).pushReplacementNamed(
              SignInScreen.routeName)
                 }
            },
          ),
          // ProfileMenu(
          //   text: "Notifications",
          //   icon: "assets/icons/Bell.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "${Utils.getTranslatedText(context,'orders')}",
            icon: "assets/icons/Cash.svg",
            press: () {
              if(loginCubit.getToken.isNotEmpty){
                Navigator.push(context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 400),
                        child: PurchasesScreen(token: loginCubit.getToken,)));
              }else{
                Navigator.of(context).pushReplacementNamed(
                    SignInScreen.routeName);
              }
            },
          ),
          ProfileMenu(
            text: loginCubit.getToken.isNotEmpty ?
            "${Utils.getTranslatedText(context,'logout')}" :
            "${Utils.getTranslatedText(context,'login')}",
            icon:  loginCubit.getToken.isNotEmpty ?
            "assets/icons/Log out.svg" : "",
            press: (){
              navigateToLoginScreen(context, loginCubit);
            },
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 3,),
          loginCubit.getToken.isNotEmpty ?
          GestureDetector(
            onTap: ()async{
              if(loginCubit.currentUser!.id != null){
                if(loginCubit.getToken.isNotEmpty){
                  dynamic result = await showDialog(
                      context: context,
                      builder: (_) =>
                          Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              backgroundColor: Colors.white,
                              child: const DeleteAccountDialog()));
                  if (result == 'delete') {
                    debugPrint(loginCubit.getToken);
                    var res = await UserHttpService().deleteAccount(loginCubit.currentToken!);
                    debugPrint(jsonDecode(res.body).toString());
                    navigateToLoginScreen(context, loginCubit);
                  }
                }
              }
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text( '${Utils.getTranslatedText(context, 'delete_account')}',style:
              TextStyle(color: Colors.grey[700],
                  fontSize: SizeConfig.blockSizeVertical! * 1.7,
                  fontWeight: FontWeight.bold),),
            ),
          ) : const SizedBox()
        ],
      ),
    );
  }

  void navigateToLoginScreen(BuildContext context,LoginCubit loginCubit)async {
    if (loginCubit.currentUser!.id != null) {
      var result = await loginCubit.logout(loginCubit.currentUser!.token!);
      if (result) {
       await Utils.getFavorites().clear();
        loginCubit.getCurrentUser('');
        Navigator.of(context).pushReplacementNamed(
            SignInScreen.routeName);
      }
    }else{
      Navigator.of(context).pushReplacementNamed(
          SignInScreen.routeName);
    }
  }
}

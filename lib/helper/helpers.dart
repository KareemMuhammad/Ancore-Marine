import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/favorite.dart';

import 'language_delegate.dart';

enum ScreenSize { small, medium, large }

class Utils{
  /////////////////////////////////////////////////////////////// constants //////////////////////////////////////////////////////////////

  static const String assetsCategoryUtil = 'https://anchormarine-kw.com/admin/images/category/';
  static const String assetsProductUtil = 'https://anchormarine-kw.com/admin/images/product/';
  static const String assetsServiceUtil = 'https://anchormarine-kw.com/admin/images/service/';
  static const String myFatoorahBaseUrl = 'https://apitest.myfatoorah.com/';
  static const String myFatoorahApiKey = 'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL';

  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);



static const double _breakPoint1 = 600.0;
static const double _breakPoint2 = 840.0;

  static ScreenSize getScreenSize(double width) {
    if (width < _breakPoint1) {
      return ScreenSize.small;
    } else if (width >= _breakPoint1 && width <= _breakPoint2) {
      return ScreenSize.medium;
    } else {
      return ScreenSize.large;
    }
  }

  static Box<Favorite> getFavorites() =>
      Hive.box<Favorite>('favorite');

  static Future<bool> isLoggedIn()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     final String? token = prefs.getString('authToken');
     if(token != null && token.isNotEmpty){
       return true;
     }else{
       return false;
     }
  }

  static Future<String> currentToken()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');
    if(token != null && token.isNotEmpty){
      return token;
    }else{
      return '';
    }
  }


static String? getTranslatedText(BuildContext context,String key){
    return AppLocale.of(context).getTranslated(key);
  }

  static String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '٤', '۵', '٦', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  static bool isRTL(String text) {
    return intl.Bidi.detectRtlDirectionality(text);
  }

  static Future showSnack(String text,String title,BuildContext context,
      Color color)async{
    await Flushbar(
      // showProgressIndicator: true,
      // progressIndicatorBackgroundColor: Colors.grey,
      messageText:Text(text,style: const TextStyle(color: Colors.white,
          fontFamily: '',fontSize: 17),),
      titleText: Text(title,style: const TextStyle(color: Colors.white,
          fontFamily: '',
              fontSize: 17,fontWeight: FontWeight.w300),),
      backgroundColor: color,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: const Icon(Icons.info,color: Colors.white,),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static int dateDifference(String date,String time){
    return DateTime(int.parse(date.split('-')[0]),int.parse(date.split('-')[1],)
        ,int.parse(date.split('-')[2]),int.parse(time.split(':')[0]),
        int.parse(time.split(':')[1]),int.parse(time.split(':')[2])).millisecondsSinceEpoch;
  }

}

class Translations {
  static final languages = <String>[
    'English',
    'عربى',
  ];

  static String getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case 'عربى':
        return 'ar';
      default:
        return 'en';
    }
  }

  static String getLanguageFromCode(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ar':
        return 'عربى';
      default:
        return 'en';
    }
  }
}

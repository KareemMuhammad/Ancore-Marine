import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_shimmer.dart';
import 'package:shop_app/size_config.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ),
  );
}

Widget servicesShimmer(){
  return MyShimmer.circular(
    width: SizeConfig.blockSizeVertical! * 6,
    height: SizeConfig.blockSizeVertical! * 6,
  );
}

Widget loadCategoriesShimmer(){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        elevation: 4,
        child: MyShimmer.rectangular(
          height: SizeConfig.screenHeight * 0.1,
          width: SizeConfig.screenWidth * 0.3,
        )
    ),
  );
}

Widget loadProductsShimmer(){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        elevation: 4,
        child: MyShimmer.rectangular(width: SizeConfig.screenWidth * 0.2,
            height: SizeConfig.screenHeight * 0.1,
          shapeBorder: const RoundedRectangleBorder(borderRadius:
          BorderRadius.all(Radius.circular(20))))
    ),
  );
}

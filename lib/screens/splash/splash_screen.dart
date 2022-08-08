import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/splash/components/splash_content.dart';
import 'package:shop_app/size_config.dart';

import '../../blocs/cart_bloc/cart_cubit.dart';
import '../../main.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: splashColor,
      body: SplashContent(
              text: 'Ancore Marine',
              image: 'assets/images/ancore_logo.jpeg',
            )
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName)
    );
  }

}

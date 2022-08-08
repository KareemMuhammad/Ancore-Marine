import 'package:flutter/material.dart';
import 'package:shop_app/helper/helpers.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${Utils.getTranslatedText(context, 'sign_in')}"),
      ),
      body: Body(),
    );
  }
}

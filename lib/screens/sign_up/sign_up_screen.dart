import 'package:flutter/material.dart';
import '../../helper/helpers.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${Utils.getTranslatedText(context, 'sign_up')}"),
      ),
      body: Body(),
    );
  }
}

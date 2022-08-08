import 'package:flutter/material.dart';

import '../../helper/helpers.dart';
import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
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

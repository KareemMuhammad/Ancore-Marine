import 'package:flutter/material.dart';
import 'package:shop_app/components/no_account_text.dart';
import '../../../helper/helpers.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "${Utils.getTranslatedText(context, 'ecommerace')}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(26),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${Utils.getTranslatedText(context, 'sign_in_hint')}",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/size_config.dart';

const kPrimaryColor = Colors.black;
const kPrimaryLightColor = Color(0xFFFFECDF);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
Color splashColor = HexColor("#111111");

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kSecondaryColor, kTextColor],
);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "من فضلك اضف بريدك الالكترونى";
const String kInvalidEmailError = "من فضلك اضف بريد الكترونى صحيح";
const String kPassNullError = "من فضلك اضف كلمة السر";
const String kShortPassError = "كلمة السر ضعيفة";
const String kMatchPassError = "كلمة السر غير متشابهة";
const String kNamelNullError = "من فضلك اضف اسمك";
const String kPhoneNumberNullError = "من فضلك اضف هاتفك الشخصى";
const String kAddressNullError = "من فضلك اضف عنوانك";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

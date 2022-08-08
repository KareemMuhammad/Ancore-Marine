import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login_bloc/login_cubit.dart';
import '../../components/custom_surfix_icon.dart';
import '../../components/default_button.dart';
import '../../components/form_error.dart';
import '../../constants.dart';
import '../../helper/helpers.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import '../../size_config.dart';

class AccountScreen extends StatefulWidget {
  final User? user;
  const AccountScreen({Key? key, this.user}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  String? firstName;
  String? phoneNumber;
  String? address;
  String? conform_password, password;

  @override
  void initState() {
    firstName = widget.user!.name;
    phoneNumber = widget.user!.mobile;
    address = widget.user!.email;
    super.initState();
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding:  EdgeInsets.all(getProportionateScreenHeight(25)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(25)),
                buildFirstNameFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPhoneNumberFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildAddressFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildConformPassFormField(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                DefaultButton(
                  text:    "${Utils.getTranslatedText(context, 'update')}",
                  press: () async{
                    if (_formKey.currentState!.validate()) {
                      var res =  await UserHttpService().updateUserDetails(firstName!,
                          address!,
                          widget.user!.token!,
                          phoneNumber!,
                        password!,
                          conform_password!,

                      );
                      debugPrint(jsonDecode(res.body).toString());
                      if(jsonDecode(res.body)['status'] != false){
                        BlocProvider.of<LoginCubit>(context)
                            .getCurrentUser(widget.user!.token!);
                        setState(() {
                          address = '';
                          firstName = '';
                          phoneNumber = '';
                          password = '';
                          conform_password = '';
                          Utils.showSnack(
                              'Your data has been updated', 'Done', context,
                              Colors.black);
                        });
                      }else{
                        Utils.showSnack(
                            jsonDecode(res.body)['message'], 'Failed', context,
                            Colors.black);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          Text(
            "${Utils.getTranslatedText(context, 'account')}",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${Utils.getTranslatedText(context,'confirm_password')}",
        hintText: "",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${Utils.getTranslatedText(context,'password')}",
        hintText: "",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          address = value;
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${Utils.getTranslatedText(context, 'email')}",
        hintText: "$address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          phoneNumber = value;
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${Utils.getTranslatedText(context, 'phone')}",
        hintText: "$phoneNumber",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }


  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          firstName = value;
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "${Utils.getTranslatedText(context, 'name')}",
        hintText: "$firstName",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}

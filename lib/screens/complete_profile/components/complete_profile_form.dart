import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import '../../../blocs/register_bloc/register_cubit.dart';
import '../../../blocs/register_bloc/register_state.dart';
import '../../../constants.dart';
import '../../../helper/helpers.dart';
import '../../../size_config.dart';
import '../../sign_in/sign_in_screen.dart';

class SignUpArguments{
  final String email;
  final String password;
  final String confirmPassword;

  SignUpArguments(this.email, this.password, this.confirmPassword);
}

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;

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
    final RegisterCubit registerCubit = BlocProvider.of<RegisterCubit>(context);
    final args = ModalRoute.of(context)!.settings.arguments as SignUpArguments;
    return BlocConsumer<RegisterCubit,RegisterState>(
        listener: (ctx,state)async{
          if(state is RegisterFailed){
            debugPrint('failed form');
           await Utils.showSnack('', state.message, context, Colors.black);
          }else if (state is RegisterSuccessful) {
            await Utils.showSnack('', state.message, ctx, Colors.black);
            Navigator.pushReplacementNamed(context, SignInScreen.routeName);
          }
        },
      builder: (context,state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              buildFirstNameFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPhoneNumberFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildAddressFormField(),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              DefaultButton(
                text: "${Utils.getTranslatedText(context, 'continue')}",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    registerCubit.signUp(firstName!, args.email, phoneNumber!,
                        args.password, address!, args.confirmPassword);
                  }
                },
              ),
            ],
          ),
        );
      }
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
        labelText: "${Utils.getTranslatedText(context, 'address')}",
        hintText: "${Utils.getTranslatedText(context, 'address_hint')}",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phoneNumber = newValue,
      maxLength: 8,
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
        hintText: "${Utils.getTranslatedText(context, 'phone_hint')}",
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
        hintText: "${Utils.getTranslatedText(context, 'name_hint')}",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}

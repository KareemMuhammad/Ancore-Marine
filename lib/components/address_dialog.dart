import 'package:flutter/material.dart';
import '../constants.dart';
import '../helper/helpers.dart';
import '../helper/language_delegate.dart';
import '../size_config.dart';

class AddressDialog extends StatefulWidget {
  const AddressDialog({Key? key}) : super(key: key);

  @override
  _AddressDialogState createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {

  String? _location;

  TextEditingController locationController = new TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.4,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.keyboard_arrow_down_rounded,size: getProportionateScreenWidth(20),),
                  color: kPrimaryColor,
                ),

                Text('${Utils.getTranslatedText(context, 'address_order')}',
                  style:  TextStyle(color: kPrimaryColor,
                      fontSize: getProportionateScreenWidth(13),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
              ],
            ),
            SizedBox(height: getProportionateScreenWidth(20),),
            header('${Utils.getTranslatedText(context, 'address')}'),
            customAddressField(),
            SizedBox(height: getProportionateScreenWidth(25),),
            ElevatedButton(
              onPressed: () {
                if(form.currentState!.validate()) {
                  Navigator.pop(context, locationController.text);
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(splashColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${Utils.getTranslatedText(context,'save')}',
                  style:  TextStyle(fontSize: getProportionateScreenWidth(14),
                      color: Colors.white,fontWeight: FontWeight.bold),),
              ),

            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }

  Widget customAddressField(){
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black12
                      .withOpacity(0.1)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(10.0))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0),
            child: Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                hintColor: Colors.white,
              ),
              child: TextFormField(
                  onSaved: (input) =>
                  _location = input,
                  controller: locationController,
                  validator: (val){
                    return val!.isNotEmpty ? null
                        : '${Utils.getTranslatedText(context, 'field_validation')}';
                  },
                  decoration: InputDecoration(
                    hintText: '${Utils.getTranslatedText(context, 'address_hint')}',
                    hintStyle: TextStyle(
                        color: Colors.black),
                    enabledBorder:
                    new UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.none),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget header(String text){
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 5.0,
          bottom: 2.0),
      child: Align(
        alignment: AppLocale.of(context).currentCode == 'en'?
        Alignment.topLeft : Alignment.topRight,
        child: Text(text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17.0),
        ),
      ),
    );
  }
}

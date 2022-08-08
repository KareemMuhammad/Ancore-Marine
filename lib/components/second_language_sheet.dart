
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

import '../blocs/language_bloc/locale_cubit.dart';
import '../helper/helpers.dart';
import '../size_config.dart';

class LanguageSheet extends StatefulWidget {
  final String? langCode;
  final LocaleCubit? langCubit;
  const LanguageSheet({Key? key, this.langCode, this.langCubit,}) : super(key: key);

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  int selectedIndex = 0;
  String langValue = 'en';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.5,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.keyboard_arrow_down_rounded,size: getProportionateScreenWidth(20),),
                  color: kPrimaryColor,
                ),

                Text('${Utils.getTranslatedText(context,'change_language')}',
                      style:  TextStyle(color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(13),
                          fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,),
              ],
            ),
          SizedBox(height: getProportionateScreenWidth(20),),
          Expanded(
            child: ListView.builder(
              itemCount: Translations.languages.length,
              itemBuilder: (BuildContext context, int index) {
               return RadioListTile(
                       value: index + 1,
                       groupValue: selectedIndex,
                       title: Text(Translations.languages[index],style:
                       TextStyle(
                         fontSize: getProportionateScreenWidth(13),
                         color: splashColor,
                         fontWeight: FontWeight.bold
                       ),),
                       activeColor: Colors.blueGrey,
                       onChanged: (value){
                          setState(() {
                            selectedIndex = index + 1;
                            switch(value){
                              case 1:
                                langValue = 'en';
                                break;
                              case 2:
                                langValue = 'ar';
                                break;
                              default: langValue = 'en';
                            }
                          });
                       });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              switch(langValue){
                case 'en':
                  widget.langCubit!.setLanguage('en');
                  break;
                case 'ar':
                  widget.langCubit!.setLanguage('ar');
                  break;
                default:  widget.langCubit!.setLanguage('en');
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
    );
  }
}

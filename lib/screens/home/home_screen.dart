import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/blocs/cart_bloc/cart_cubit.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/categories/categories_screen.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/services/services_screen.dart';
import '../../blocs/language_bloc/locale_cubit.dart';
import '../../blocs/login_bloc/login_cubit.dart';
import '../../blocs/login_bloc/login_state.dart';
import '../../components/second_language_sheet.dart';
import '../../helper/helpers.dart';
import '../../helper/language_delegate.dart';
import '../../main.dart';
import '../../size_config.dart';
import '../about/about_screen.dart';
import 'components/body.dart';
import 'components/icon_btn_with_counter.dart';
import 'components/search_field.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {

    if(userToken != null) {
      BlocProvider.of<CartCubit>(context).
      getMyOrders(userToken!);

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    final LocaleCubit langCubit = BlocProvider.of<LocaleCubit>(context);
    print(loginCubit.getToken);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                      builder: (context) {
                        return IconBtnWithCounter(
                          svgSrc: "assets/icons/menu.svg",
                          color: kPrimaryColor,
                          press: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      }
                  ),
                  SectionTitle(title: '${Utils.getTranslatedText(context, 'ecommerace')}', press: (){}),
                  CircleAvatar(
                    radius: 27,
                    backgroundImage: AssetImage('assets/images/ancore_logo.jpeg'),
                  ),
                ],
              ),
            ),
            Expanded(child: Body()),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      drawer: BlocBuilder<LoginCubit,LoginState>(
          builder: (context,state) {
          return SafeArea(
            child: Drawer(
              elevation: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: splashColor
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    BlocBuilder<LocaleCubit,LocaleState>(
                        builder: (context,state) {
                        return Align(
                          alignment: state.locale.languageCode == 'en'?
                          Alignment.topLeft : Alignment.topRight,
                          child: Builder(
                              builder: (context) {
                                return IconBtnWithCounter(
                                  svgSrc: "assets/icons/menu.svg",
                                  press: () {
                                    Scaffold.of(context).closeDrawer();
                                  }, color: Colors.white,
                                );
                              }
                          ),
                        );
                      }
                    ),
                    SizedBox(height: getProportionateScreenWidth(20)),
                    ListTile(
                      leading: SvgPicture.asset("assets/icons/User.svg",color: Colors.white,),
                      title: Text(
                          state is LoginSuccessful?
                          '${Utils.getTranslatedText(context, 'welcome')}  ${state.appUser.name}':
                          loginCubit.currentUser != null ?
                          '${Utils.getTranslatedText(context, 'welcome')} ${loginCubit.currentUser!.name ?? 'Guest'}'
                              : '${Utils.getTranslatedText(context, 'welcome')} Guest',
                          style: TextStyle(fontSize: SizeConfig.blockSizeVertical! * 2.1,
                            color: Colors.white,)
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: Colors.white,),
                    ),
                    ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 19,),
                      leading: Icon(FontAwesomeIcons.info,size: SizeConfig.blockSizeVertical! * 2.2,color: Colors.white,),
                      title:  Text('${Utils.getTranslatedText(context,'about')}',
                        style:  TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 2.1,
                          color: Colors.white,
                        ),),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 400),
                              child: AboutUsScreen(code: AppLocale.of(context).currentCode,),));
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: Colors.white,),
                    ),
                    ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 19,),
                      leading: Icon(Icons.category,size: SizeConfig.blockSizeVertical! * 2.2,color: Colors.white,),
                      title:  Text('${Utils.getTranslatedText(context, 'categories')}',
                        style:  TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 2.1,
                          color: Colors.white,
                        ),),
                      onTap: (){
                        Navigator.push(context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 400),
                                child: CategoriesScreen(categoriesList: [],)));
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: Colors.white,),
                    ),
                    ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 19,),
                      leading: Icon(Icons.miscellaneous_services_outlined,
                        size: SizeConfig.blockSizeVertical! * 2.2,color: Colors.white,),
                      title:  Text('${Utils.getTranslatedText(context, 'services')}',
                        style:  TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 2.1,
                          color: Colors.white,
                        ),),
                      onTap: (){
                        Navigator.push(context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 400),
                                child: ServicesScreen()));
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: Colors.white,),
                    ),
                    BlocBuilder<LocaleCubit,LocaleState>(
                        builder: (context,state) {
                          return GestureDetector(
                            onTap: (){
                              _showMySheet(context, state.locale.languageCode, langCubit);
                            },
                            child: ListTile(
                              trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 19,),
                              leading: Icon(Icons.language,size: SizeConfig.blockSizeVertical! * 2.2,color: Colors.white,),
                              title:  Text('${Utils.getTranslatedText(context,'language')}',
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical! * 2.1,
                                  color: Colors.white,
                                ),),
                            ),
                          );
                        }
                    ),
                    const Spacer(),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Image.asset('assets/images/ancore_logo.jpeg',height: SizeConfig.blockSizeVertical! * 11,
                    //         width: SizeConfig.blockSizeVertical! * 11,),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child: Text('${Utils.getTranslatedText(context, 'follow')}',
                        style: TextStyle(color: Colors.white,
                            fontSize: SizeConfig.blockSizeVertical! * 2.3,
                            fontWeight: FontWeight.bold),),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: (){

                          }, icon: const Icon(Icons.whatsapp),
                          iconSize: SizeConfig.blockSizeVertical! * 3,color: Colors.white,),
                        IconButton(
                          onPressed: (){

                          }, icon: const Icon(Icons.email),
                          iconSize: SizeConfig.blockSizeVertical! * 3,color: Colors.white,),
                        IconButton(
                          onPressed: (){

                          }, icon: const Icon(Icons.facebook),
                          iconSize: SizeConfig.blockSizeVertical! * 3,color: Colors.white,),
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 1.5,),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  void _showMySheet(BuildContext context,String code,LocaleCubit langCubit) {
    showModalBottomSheet(context: context, builder: (_){
      return LanguageSheet(langCode: code,langCubit: langCubit,);
    },
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
      ),
    );
  }
}

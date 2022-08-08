import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../blocs/login_bloc/login_cubit.dart';
import '../../blocs/maintenance_services_bloc/maintenance_cubit.dart';
import '../../blocs/maintenance_services_bloc/maintenance_state.dart';
import '../../constants.dart';
import '../../helper/helpers.dart';
import '../../helper/language_delegate.dart';
import '../../size_config.dart';
import '../../theme.dart';
import '../home/components/section_title.dart';
import '../reservation/reservation_screen.dart';
import '../sign_in/sign_in_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {

  @override
  void initState() {
    BlocProvider.of<MaintenanceCubit>(context).getServices();
    BlocProvider.of<MaintenanceCubit>(context).getSlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
          child: SectionTitle(title: '${Utils.getTranslatedText(context, 'services')}', press: (){}),
        ),
      ),
      body: BlocBuilder<MaintenanceCubit,MaintenanceState>(
          builder: (context,state) {
            return Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Column( crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: getProportionateScreenWidth(15)),
                   state is MaintenanceSuccessful?
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.services.length,
                          itemBuilder: (context,index) {
                            return Padding(
                                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                                  child: ServicesWidget(
                                    icon: state.services[index].image!,
                                    text: AppLocale.of(context).currentCode == 'ar' ?
                                    state.services[index].nameAr
                                    :state.services[index].nameEn!,
                                    press: () {
                                      if(loginCubit.currentUser != null) {
                                        if (loginCubit.currentToken != null
                                            && loginCubit.currentToken!.isNotEmpty) {
                                          if (BlocProvider
                                              .of<MaintenanceCubit>(context)
                                              .slots.isNotEmpty) {
                                            Navigator.push(context,
                                                PageTransition(
                                                    type: PageTransitionType.
                                                    rightToLeft,
                                                    duration: const Duration(
                                                        milliseconds: 400),
                                                    child: ReservationScreen(
                                                      service: state.services[index],
                                                      slots: BlocProvider
                                                          .of<MaintenanceCubit>
                                                        (context).slots,)));
                                          }
                                        }else{
                                          Navigator.pushNamed(context, SignInScreen.routeName);
                                        }
                                      }else{
                                        Navigator.pushNamed(context, SignInScreen.routeName);
                                      }
                                    },
                                  ),
                            );
                          }
                        ),
                      ) : Expanded(
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (ctx,index){
                          return Padding(
                            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                            child: loadCategoriesShimmer(),
                          );
                        }),
                      ),
                  SizedBox(height: getProportionateScreenWidth(20)),
                ],
              ),
            );
          }
      ),
    );
  }
}

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.16,
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(5),
        ),
        decoration: BoxDecoration(
          color: Colors.blue[800]!.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: splashColor.withOpacity(0.3),
                blurRadius: 15.0,
                offset: Offset(0.0, 0.75))
          ],
          image: DecorationImage(
              image: CachedNetworkImageProvider(icon!,),
           fit: BoxFit.cover
          )
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: splashColor.withOpacity(0.5),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                         text!,
                         style: TextStyle(
                           fontSize: getProportionateScreenWidth(17),
                           color: Colors.white,
                           shadows: [
                             Shadow(
                          color: splashColor,
                          blurRadius: 8.0,
                          offset: Offset(0.0, 0.75))
                           ]
                         ),
                       ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}

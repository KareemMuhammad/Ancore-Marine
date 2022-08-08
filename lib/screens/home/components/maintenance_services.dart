import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/blocs/login_bloc/login_cubit.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/reservation/reservation_screen.dart';
import 'package:shop_app/theme.dart';
import '../../../blocs/maintenance_services_bloc/maintenance_cubit.dart';
import '../../../blocs/maintenance_services_bloc/maintenance_state.dart';
import '../../../helper/helpers.dart';
import '../../../helper/language_delegate.dart';
import '../../../size_config.dart';
import '../../sign_in/sign_in_screen.dart';

class MaintenanceServicesWidget extends StatefulWidget {

  @override
  State<MaintenanceServicesWidget> createState() => _MaintenanceServicesWidgetState();
}

class _MaintenanceServicesWidgetState extends State<MaintenanceServicesWidget> {
  @override
  void initState() {
    BlocProvider.of<MaintenanceCubit>(context).getServices();
    BlocProvider.of<MaintenanceCubit>(context).getSlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return BlocBuilder<MaintenanceCubit,MaintenanceState>(
        builder: (context,state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(title: '${Utils.getTranslatedText(context, 'services')}', press: (){}),
              ),
              SizedBox(height: getProportionateScreenWidth(15)),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state is MaintenanceSuccessful?
                    List.generate(
                      state.services.length,
                          (index) => MaintenanceServicesCard(
                        icon: state.services[index].image!,
                        text: AppLocale.of(context).currentCode == 'ar' ?
                        state.services[index].nameAr
                            :state.services[index].nameEn!,
                        press: () {
                          if(loginCubit.currentUser != null) {
                            if (loginCubit.currentToken != null
                                && loginCubit.currentToken!.isNotEmpty) {
                              if (BlocProvider
                                  .of<MaintenanceCubit>(context).slots
                                  .isNotEmpty) {
                                Navigator.push(context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
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
                    ) : List.generate(
                      4, (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                      child: servicesShimmer(),
                    ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
            ],
          );
        }
    );
  }
}

class MaintenanceServicesCard extends StatelessWidget {
  const MaintenanceServicesCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(70),
          child: Column(
            children: [

                CircleAvatar(
                  radius: SizeConfig.screenWidth * 0.08,
                  backgroundImage: CachedNetworkImageProvider( icon!),
                ),
              SizedBox(height: 5),
              Text(text!, textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[800]),)
            ],
          ),
        ),
      ),
    );
  }
}

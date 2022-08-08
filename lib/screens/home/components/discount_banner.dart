import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      height: SizeConfig.screenHeight * 0.16,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),

      decoration: BoxDecoration(
        color: splashColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Swiper(
        loop: false,
        autoplay: true,
        duration: 900,
        scrollDirection: Axis.vertical,
        itemCount: 2,
        itemBuilder: (BuildContext context, int imageIndex) {
          return GestureDetector(
            onTap: ()async{
              if(imageIndex == 0) {
              //  await launch(state.adsModel!.urlLeft!);
              }else{
               // await launch(state.adsModel!.urlRight!);
              }
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset('assets/images/bannercruise.jpg',
                  fit: BoxFit.fitWidth,)
            ),
          );
        },
      ),
    );
  }
}

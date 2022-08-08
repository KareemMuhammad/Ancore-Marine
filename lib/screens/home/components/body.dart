import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/maintenance_services.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'best_selling.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DiscountBanner(),
            CategoriesWidget(),
            MaintenanceServicesWidget(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            BestSelling(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}

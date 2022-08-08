import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/blocs/categories_bloc/categories_cubit.dart';
import 'package:shop_app/blocs/categories_bloc/categories_state.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/theme.dart';
import '../../../helper/helpers.dart';
import '../../../helper/language_delegate.dart';
import '../../../size_config.dart';

class CategoriesWidget extends StatefulWidget {

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  void initState() {
    BlocProvider.of<CategoriesCubit>(context).getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit,CategoriesState>(
      builder: (context,state) {
        return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(title: '${Utils.getTranslatedText(context, 'categories')}', press: (){}),
              ),
              SizedBox(height: getProportionateScreenWidth(15)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state is CategoriesSuccessful?
                  List.generate(
                    state.categories.length,
                    (index) => CategoryCard(
                      icon: state.categories[index].image!,
                      category: AppLocale.of(context).currentCode == 'ar' ?
                      state.categories[index].nameAr
                          :state.categories[index].nameEn!,
                      press: () {
                        Navigator.push(context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 400),
                                child: ProductsScreen(category: state.categories[index])));
                      },
                    ),
                  ) : List.generate(
                      4, (index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10)),
                        child: loadCategoriesShimmer(),
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

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.category,
    required this.press,
  }) : super(key: key);

  final String? icon, category;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(200),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(icon!,)
                      )
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(17),
                              fontWeight: FontWeight.bold,
                              shadows: [
                                BoxShadow(color: splashColor.withOpacity(0.8),offset: Offset(-1,0.1))
                              ]
                          ),
                        ),
                      ],
                    ),
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

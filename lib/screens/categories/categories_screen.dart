import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/helper/language_delegate.dart';
import 'package:shop_app/models/category.dart';
import '../../blocs/categories_bloc/categories_cubit.dart';
import '../../blocs/categories_bloc/categories_state.dart';
import '../../helper/helpers.dart';
import '../../size_config.dart';
import '../../theme.dart';
import '../home/components/section_title.dart';
import '../products/products_screen.dart';
import '../services/services_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Categories> categoriesList;
  const CategoriesScreen({Key? key, required this.categoriesList}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  @override
  void initState() {
    BlocProvider.of<CategoriesCubit>(context).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
          child: SectionTitle(title: '${Utils.getTranslatedText(context, 'categories')}', press: (){}),
        ),
      ),
      body : BlocBuilder<CategoriesCubit,CategoriesState>(
          builder: (context,state) {
            return catCustom(state);
          }
      ),
    );
  }

  Widget catCustom(CategoriesState state){
    return Column( crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: getProportionateScreenWidth(15)),
        state is CategoriesSuccessful?
        Expanded(
          child: ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context,index) {
                return Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  child: ServicesWidget(
                    icon: state.categories[index].image!,
                    text: AppLocale.of(context).currentCode == 'ar' ?
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
    );
  }
}

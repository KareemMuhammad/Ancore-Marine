import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/repositories/products_repo.dart';
import '../../../helper/helpers.dart';
import '../../../helper/language_delegate.dart';
import '../../../models/product_model.dart';
import '../../../size_config.dart';
import '../../../theme.dart';
import '../../details/details_screen.dart';
import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  List<Products>? products = [];
  final ProductsRepo _productsRepo = ProductsRepo();

  @override
  void initState() {
    Future.microtask(() async{
      ProductHolder holder = await _productsRepo.getOffersResponse();
      products = holder.products;
      if(mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "${Utils.getTranslatedText(context, 'offer')}",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(15)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products!.isNotEmpty?
            List.generate(
              products!.length,
              (index) => SpecialOfferCard(
                    image: products![index].images!.first.name!,
                    category: AppLocale.of(context).currentCode == 'en' ?
                    products![index].nameEn! : products![index].nameAr!,
                    offer: products![index].offer!.toInt().toString(),
                    press: () => Navigator.pushNamed(
                        context,
                        DetailsScreen.routeName,
                        arguments: ProductDetailsArguments(product: products![index],
                          images: products![index].images!,),
                 ),
              )
              ) : List.generate(
                  4, (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                    child: loadCategoriesShimmer(),
              ),
              ),
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.offer,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final String offer;
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
                      image: CachedNetworkImageProvider(image,)
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
               offer.isNotEmpty?
               Positioned(
                  bottom: 0,
                  right: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(30)
                    ), padding: const EdgeInsets.all(6),
                    child: Text('$offer%',style: TextStyle(color: Colors.white),),
                  ),
                ) : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

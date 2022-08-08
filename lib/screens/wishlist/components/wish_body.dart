import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/favorite.dart';
import 'package:shop_app/screens/wishlist/components/wish_card.dart';
import '../../../blocs/login_bloc/login_cubit.dart';
import '../../../constants.dart';
import '../../../helper/helpers.dart';
import '../../../size_config.dart';

class WishBody extends StatefulWidget {
  final List<Favorite> wishList;

  const WishBody({Key? key, required this.wishList}) : super(key: key);
  @override
  _WishBodyState createState() => _WishBodyState();
}

class _WishBodyState extends State<WishBody> {
  late String token;
  @override
  void initState() {
    token = BlocProvider.of<LoginCubit>(context).getToken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: widget.wishList.isEmpty?
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 0),
        child: Center(child: Text( '${Utils.getTranslatedText(context, 'empty_wish')}', style: TextStyle(
            color: Colors.grey[700],fontSize: getProportionateScreenWidth(15)
        ),)),
      )
          : ListView.builder(
            itemCount: widget.wishList.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(widget.wishList[index].product!.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async{
                  widget.wishList[index].delete();
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    WishCard(wish: widget.wishList[index].product!),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Divider(color: kSecondaryColor.withOpacity(0.5),),
                    )
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/helper/language_delegate.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/repositories/user_repo.dart';
import '../../helper/helpers.dart';
import '../../size_config.dart';
import 'package:timeago/timeago.dart' as timeago;

class PurchasesScreen extends StatefulWidget {
  final String token;
  const PurchasesScreen({Key? key, required this.token}) : super(key: key);

  @override
  _PurchasesScreenState createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {


  late List<Orders> purchaseList = [];
  final f = new DateFormat('yyyy-MM-dd hh:mm');

  @override
  void initState() {
    debugPrint(widget.token);
    Future.microtask(() async{
     CartHolder model = await UserRepository().getMyPurchasesResponse(widget.token);
     purchaseList = model.orders!;
     if(mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(Utils.getTranslatedText(context,'orders')!,
          style:
          TextStyle(color: Colors.black, fontSize: SizeConfig.blockSizeVertical! * 2,
              fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          await Future.delayed(const Duration(seconds: 1));
          CartHolder model = await UserRepository().getMyPurchasesResponse(widget.token);
          setState(() {
            purchaseList = model.orders!;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: purchaseList.isNotEmpty?
              ListView.builder(
                itemCount: purchaseList.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (ctx,index){
                    var pure = purchaseList[index];
                 return Column(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     textSmall(getMemberTime(pure.date!,AppLocale.of(context).currentCode)),
                     SizedBox(height: SizeConfig.blockSizeVertical! * 1,),
                     Card(
                       elevation: 3,
                       color: Color(0xFFF5F6F9),
                       child: ListTile(
                         leading: pure.image == null?
                             SizedBox()
                         :CachedNetworkImage(imageUrl: pure.image!.name!,),
                         title: footer(AppLocale.of(context).currentCode == 'en' ?
                         pure.product!.nameEn.toString() : pure.product!.nameAr.toString()),
                         subtitle: footer(pure.product!.price!),
                       ),
                     ),
                   ],
                 );
              }) : Center(child: Column(
                children: [
                  SizedBox(height: SizeConfig.blockSizeVertical! * 3,),
                  SvgPicture.asset(
                    "assets/icons/Cash.svg",
                    color: kPrimaryColor,
                    width: 35,
                    height: 35,
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 1.5,),
                  footer('${Utils.getTranslatedText(context,'purchases_hint')}'),
                ],
              )),

        ),
      ),
    );
  }

  Widget footer(String text){
    return Text('$text',style:
    TextStyle(color: Colors.black, fontSize: SizeConfig.blockSizeVertical! * 1.6,
        fontWeight: FontWeight.bold,height: 1.5),textAlign: TextAlign.start,);
  }

  Widget textSmall(String text){
    return Text(text,style:
    TextStyle(color: Colors.black, fontSize: SizeConfig.blockSizeVertical! * 1.6,
        fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
  }

  String getMemberTime(String date,String local){
    if(local == 'en') {
      timeago.setLocaleMessages(local, timeago.EnMessages());
    }else{
      timeago.setLocaleMessages(local, timeago.ArMessages());
    }
    debugPrint('locale= ' + local);
    String timeAgo = '';
    if(date.isNotEmpty) {
      DateTime time = DateTime.parse(date);
      timeAgo = timeago.format(time, locale: local);
    }
    return timeAgo;
  }
}

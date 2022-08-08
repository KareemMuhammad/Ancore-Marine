import 'dart:convert';
import 'package:http/http.dart';
import '../services/ads_service.dart';

// class AdsRepo{
//   final AdsService _adsService = AdsService();
//
//   Future<List<AdsModel>> loadAds()async{
//    Response response = await _adsService.getAdsPhoto();
//    if(response.statusCode == 200){
//      List list = jsonDecode(response.body)['images'];
//      return list.map((e) => AdsModel.fromJson(e)).toList();
//    }else{
//      return [];
//    }
//   }
// }
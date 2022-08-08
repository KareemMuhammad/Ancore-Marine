import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'base_api.dart';

class PaymentService extends BaseAPI{

  Future<Response> payService(String token,String name,String address,
      String boatData, DateTime date,int timeSlotId, int serviceId,String mobile,
    )async{
    try {
      Response response = await post(Uri.parse(super.payServicesPath +
          'auth_token=$token&' +  'name=$name&' +  'address=$address&' +
          'day=$date&' + 'time=$timeSlotId&' +  'service_id=$serviceId&'
          +'mobile=$mobile&' + 'boatdata=$boatData'),
          headers: super.headers);

      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> payOrder(String token,String address)async{
    try {

      Response response = await post(Uri.parse(super.payOrderPath),
          body: {
            "auth_token" : token,
            "address": address
          },
          headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

}
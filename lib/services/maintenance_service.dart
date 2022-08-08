import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'base_api.dart';

class MaintenanceServicesClient extends BaseAPI{

  Future<Response> fetchServices()async{
    try {
      Response response = await post(Uri.parse(super.servicesPath));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future fetchSlots()async{
    try {
      Response response = await post(Uri.parse(super.slotsPath));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }
}
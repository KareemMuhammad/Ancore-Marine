import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_app/services/maintenance_service.dart';
import '../models/services.dart';
import '../models/slots.dart';

class MaintenanceRepo{
  final MaintenanceServicesClient _client = MaintenanceServicesClient();

  Future<MaintenanceServicesHolder> getServicesResponse()async{
    Response response = await _client.fetchServices();
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['services'] != null) {
        List cat = jsonDecode(response.body)['services'];
        return MaintenanceServicesHolder(
            services: cat.map((e) => Services.fromJson(e)).toList(),
            message: jsonDecode(response.body)['message']);
      }else{
        return MaintenanceServicesHolder(
            services: [],
            message: jsonDecode(response.body)['message']);
      }
    }else{
      return MaintenanceServicesHolder(services: [],
          message: 'Error in server');
    }
  }

  Future<SlotsHolder> getSlotsResponse()async{
    Response response = await _client.fetchSlots();
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['Slots'] != null) {
        List cat = jsonDecode(response.body)['Slots'];
        return SlotsHolder(
            slots: cat.map((e) => Slots.fromJson(e)).toList(),
            message: jsonDecode(response.body)['message']);
      }else{
        return SlotsHolder(
            slots: [],
            message: jsonDecode(response.body)['message']);
      }
    }else{
      return SlotsHolder(slots: [],
          message: 'Error in server');
    }
  }
}
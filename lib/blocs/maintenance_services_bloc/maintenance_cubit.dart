import 'package:bloc/bloc.dart';
import 'package:shop_app/blocs/maintenance_services_bloc/maintenance_state.dart';
import 'package:shop_app/repositories/maintenance_repo.dart';
import '../../models/services.dart';
import '../../models/slots.dart';

class MaintenanceCubit extends Cubit<MaintenanceState>{
  final MaintenanceRepo? maintenanceRepo;
  MaintenanceCubit({this.maintenanceRepo}) : super(MaintenanceInitial());

  List<Services>? servicesList;
  List<Slots> _slots = [];


  List<Slots> get slots => _slots;

  void getServices()async{
    emit(MaintenanceLoading());
    MaintenanceServicesHolder holder = await maintenanceRepo!.getServicesResponse();
    if(holder.services!.isNotEmpty){
      servicesList = holder.services;
      emit(MaintenanceSuccessful(servicesList!));
    }else{
      emit(MaintenanceFailed());
    }
  }

  void getSlots()async{
    SlotsHolder holder = await maintenanceRepo!.getSlotsResponse();
    _slots = holder.slots!;
  }

}
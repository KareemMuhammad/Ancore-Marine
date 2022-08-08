import 'package:flutter/material.dart';
import 'package:shop_app/models/services.dart';

@immutable
abstract class MaintenanceState{}

class MaintenanceInitial extends MaintenanceState{}

class MaintenanceLoading extends MaintenanceState{}

class MaintenanceFailed extends MaintenanceState{}

class MaintenanceSuccessful extends MaintenanceState{
  final List<Services> services;

  MaintenanceSuccessful(this.services);
}
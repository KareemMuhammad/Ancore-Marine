import 'package:flutter/material.dart';
import 'package:shop_app/helper/language_delegate.dart';
import 'package:shop_app/models/services.dart';
import 'package:shop_app/screens/reservation/components/reservation_widget.dart';

import '../../models/slots.dart';

class ReservationScreen extends StatelessWidget {
  final Services service;
  final List<Slots> slots;

  const ReservationScreen({Key? key, required this.service,
    required this.slots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocale.of(context).currentCode == 'en'?
          service.nameEn! : service.nameAr!,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ReservationWidget(slots: slots,service: service,),
    );
  }
}

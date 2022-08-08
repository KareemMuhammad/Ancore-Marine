import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/helper/helpers.dart';
import 'package:shop_app/helper/language_delegate.dart';
import 'package:shop_app/models/services.dart';
import 'package:shop_app/screens/payment/myfatoorah_screen.dart';
import '../../../blocs/login_bloc/login_cubit.dart';
import '../../../components/default_button.dart';
import '../../../models/slots.dart';
import '../../../services/payment_service.dart';
import '../../../size_config.dart';
import '../../details/components/top_rounded_container.dart';
import '../../profile/profile_screen.dart';

class ReservationWidget extends StatefulWidget {
final List<Slots> slots;
final Services service;

  const ReservationWidget({Key? key, required this.slots, required this.service}) : super(key: key);

  @override
  _ReservationWidgetState createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationWidget> {
  String? _valOccasion;

  DateTime selectedDate = DateTime.now();

  String? _setCheckIn, _location,_name,_mobile,_boat,_comments;

  TextEditingController locationController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController boatController = new TextEditingController();
  TextEditingController addCommentsController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);

    return  Form(
          key: form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                header('${Utils.getTranslatedText(context, 'name')}'),
                customNameField(),
                SizedBox(height: 20,),
                header('${Utils.getTranslatedText(context, 'phone')}'),
                customMobileField(),
                SizedBox(height: 20,),
                header('${Utils.getTranslatedText(context, 'boat_data')}'),
                customBoatField(),
                SizedBox(height: 20,),
                header('${Utils.getTranslatedText(context, 'address')}'),
                customAddressField(),
                SizedBox(height: 20,),
                header('${Utils.getTranslatedText(context, 'date')}'),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0),
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.black12
                                  .withOpacity(0.1)),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0))),
                    child: Center(
                      child: Theme(
                        data: ThemeData(
                            canvasColor: Colors.deepPurpleAccent),
                        child: InkWell(
                          onTap: () {
                            _selectDateCheckIn(context);
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: double.infinity,
                              height: 55.0,
                              alignment: Alignment.center,
                              child: TextFormField(
                                validator: (val){
                                  return val!.isNotEmpty ? null : 'please fill this form';
                                },
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                onSaved: (String? val) {
                                  _setCheckIn = val;
                                },
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: dateController,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.red),
                                  enabledBorder:
                                  new UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                        style: BorderStyle.none),
                                  ),
                                  contentPadding:
                                  EdgeInsets.all(13.0),
                                  hintText: "${Utils.getTranslatedText(context, 'date')}",
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black),
                                  // labelText: 'Time',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                header('${Utils.getTranslatedText(context, 'time')}'),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0),
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.black12
                                  .withOpacity(0.1)),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0),
                      child: DropdownButton(
                        hint: Text(
                          '${widget.slots.first.start} - ${widget.slots.first.end}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0),
                        ),
                        underline: Container(),
                        style: TextStyle(
                            color: Colors.black),
                        value: _valOccasion,
                        items: widget.slots.map((value) {
                          return DropdownMenuItem(
                            child: Text('${value.start} - ${value.end}'),
                            value: '${value.start} ${value.end}',
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _valOccasion = value.toString();
                            debugPrint(_valOccasion);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                header('${Utils.getTranslatedText(context, 'additional_comments')}'),
                customCommentsField(),
                SizedBox(height: 10,),
                TopRoundedContainer(
                  color: Color(0xFFF6F7F9),
                  child: TopRoundedContainer(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.15,
                        right: SizeConfig.screenWidth * 0.15,
                        bottom: getProportionateScreenWidth(40),
                      ),
                      child: DefaultButton(
                        text: "${Utils.getTranslatedText(context, 'reservation_btn')}",
                        press: () async{
                          if(form.currentState!.validate() && _valOccasion != null) {

                              var sl = widget.slots.where((element) =>
                              element.start == _valOccasion!.split(' ')[0]).first;

                              var res = await PaymentService().payService(
                                  loginCubit.currentToken!,
                                  nameController.text,
                                  locationController.text,
                                  boatController.text,
                                  selectedDate,
                                  sl.id!,
                                  widget.service.id!,
                                  mobileController.text);

                              debugPrint(jsonDecode(res.body).toString());

                              if(jsonDecode(res.body)['data'] != null){
                                var result = await Navigator.pushReplacement(context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          duration: const Duration(milliseconds: 400),
                                          child: MyFatoorahScreen(url: jsonDecode(res.body)['data'],)));
                                if(result == 'success'){
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
                                }
                              }else{
                                Utils.showSnack(
                                    jsonDecode(res.body)['message'], 'Failed', context,
                                    Colors.black);
                              }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget header(String text){
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 5.0,
          bottom: 2.0),
      child: Align(
        alignment: AppLocale.of(context).currentCode == 'en'?
        Alignment.topLeft : Alignment.topRight,
        child: Text(text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17.0),
        ),
      ),
    );
  }

  Future<Null> _selectDateCheckIn(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Widget customAddressField(){
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black12
                      .withOpacity(0.1)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(10.0))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0),
            child: Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                hintColor: Colors.white,
              ),
              child: TextFormField(
                  onSaved: (input) =>
                  _location = input,
                  controller: locationController,
                  validator: (val){
                    return val!.isNotEmpty ? null
                        : '${Utils.getTranslatedText(context, 'field_validation')}';
                  },
                  decoration: InputDecoration(
                    hintText: '${Utils.getTranslatedText(context, 'address_hint')}',
                    hintStyle: TextStyle(
                        color: Colors.black),
                    enabledBorder:
                    new UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.none),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget customBoatField(){
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black12
                      .withOpacity(0.1)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(10.0))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0),
            child: Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                hintColor: Colors.white,
              ),
              child: TextFormField(
                  validator: (val){
                    return val!.isNotEmpty ? null:
                    '${Utils.getTranslatedText(context, 'field_validation')}';
                  },
                  onSaved: (input) =>
                  _boat = input,
                  controller: boatController,
                  decoration: InputDecoration(
                    hintText: '${Utils.getTranslatedText(context, 'boat_hint')}',
                    hintStyle: TextStyle(
                        color: Colors.black),
                    enabledBorder:
                    new UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.none),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget customNameField(){
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black12
                      .withOpacity(0.1)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(10.0))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0),
            child: Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                hintColor: Colors.white,
              ),
              child: TextFormField(
                  validator: (val){
                    return val!.isNotEmpty ? null :
                    '${Utils.getTranslatedText(context, 'field_validation')}';
                  },
                  onSaved: (input) =>
                  _name = input,
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: '${Utils.getTranslatedText(context, 'name_hint')}',
                    hintStyle: TextStyle(
                        color: Colors.black),
                    enabledBorder:
                    new UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.none),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget customMobileField(){
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        height: 70.0,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black12
                      .withOpacity(0.1)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(10.0))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0),
            child: Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                hintColor: Colors.white,
              ),
              child: TextFormField(
                  validator: (val){
                    return val!.isNotEmpty && val.length > 7? null :
                    '${Utils.getTranslatedText(context, 'field_validation')}';
                  },
                  onSaved: (input) =>
                  _mobile = input,
                  controller: mobileController,
                  maxLength: 8,
                  decoration: InputDecoration(
                    hintText: '${Utils.getTranslatedText(context, 'phone_hint')}',
                    hintStyle: TextStyle(
                        color: Colors.black),
                    helperStyle: TextStyle(
                        color: Colors.black),
                    enabledBorder:
                    new UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.none),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget customCommentsField(){
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black12
                      .withOpacity(0.1)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(10.0))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0),
            child: Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                hintColor: Colors.white,
              ),
              child: TextFormField(
                  onSaved: (input) =>
                  _comments = input,
                  controller: addCommentsController,
                  decoration: InputDecoration(
                    hintText: '${Utils.getTranslatedText(context, 'additional_comments_hint')}',
                    hintStyle: TextStyle(
                        color: Colors.black),
                    enabledBorder:
                    new UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.none),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

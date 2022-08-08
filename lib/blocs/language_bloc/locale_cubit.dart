import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const SelectedLocale(Locale('ar')));

  void setLanguage(String code) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', code);
    emit(SelectedLocale(Locale(code)));
  }

  void getStartLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('lang');
    if (langCode != null) {
      emit(SelectedLocale(Locale(langCode)));
    }else{
      emit( const SelectedLocale(Locale('ar')));
    }
  }
}
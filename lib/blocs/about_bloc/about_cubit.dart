import 'package:bloc/bloc.dart';

import '../../models/about_model.dart';
import '../../services/about_service.dart';
import 'about_state.dart';

class AboutCubit extends Cubit<AboutState>{
  final AboutService? aboutService;

  AboutCubit({this.aboutService}) : super(AboutInitial());

  List<AboutModel>? aboutList;

  void getCurrentAboutLang(String local)async{
    emit(AboutLoading());
    aboutList = await aboutService!.getAboutLanguage(local);
    if(aboutList!.isNotEmpty){
      emit(AboutLoaded(aboutList));
    }else{
      emit(AboutLoadFailure());
    }
  }
}
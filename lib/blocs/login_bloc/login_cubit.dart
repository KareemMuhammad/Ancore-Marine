import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../repositories/user_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  final UserRepository? userRepository;
  LoginCubit({this.userRepository}) : super(LoginInitial());

  String? currentToken = '';
  User? currentUser = User();

  User get getUser => currentUser!;
  String get getToken => currentToken!;

  void login(String email,String password)async{
    emit(LoadingLogin());
   UserHolder responseModel = await userRepository!.loginResponse(email, password);
   if(responseModel.user!.token != null){
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('authToken', responseModel.user!.token!);
     currentToken = responseModel.user!.token;
     emit(LoginSuccessful(responseModel.user!));
   }else{
     emit(LoginFailed(responseModel.message!));
   }
  }

  Future<bool> logout(String token)async{
    bool result = await userRepository!.logOutResponse(token);
    if(result){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('authToken', '');
      currentToken = '';
      currentUser = User();
      emit(LoginInitial());
    }
   return result;
  }

  void getCurrentUser(String token)async{
    UserHolder responseModel = await userRepository!.getUser(token);
    if(responseModel.user!.id != null){
      debugPrint('name = ' + responseModel.user!.name!);
      currentUser = responseModel.user;
      currentToken = responseModel.user!.token;
    }
  }

}
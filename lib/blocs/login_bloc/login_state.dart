import 'package:flutter/material.dart';

import '../../models/user.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState{}

class LoadingLogin extends LoginState{}

class LoginSuccessful extends LoginState{
  final User appUser;

  LoginSuccessful(this.appUser);
}

class LoginFailed extends LoginState{
  final String message;

  LoginFailed(this.message);
}



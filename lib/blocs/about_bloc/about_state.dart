import 'package:flutter/material.dart';

import '../../models/about_model.dart';

@immutable
abstract class AboutState{}

class AboutInitial extends AboutState{}

class AboutLoading extends AboutState{}

class AboutLoadFailure extends AboutState{}

class AboutLoaded extends AboutState{
  final List<AboutModel>? aboutModel;

  AboutLoaded(this.aboutModel);
}
import 'package:flutter/material.dart';

class AboutModel{
  final String? aboutPf;
  final String? aboutPs;
  final String? principles;
  final String? mission;
  final String? vision;

  AboutModel({
     @required this.aboutPf,
    @required this.aboutPs,@required this.principles,
    @required this.mission,@required this.vision});

  const AboutModel.dummy({@required this.aboutPf,
    @required this.aboutPs,@required this.principles,
    @required this.mission,@required this.vision});

  factory AboutModel.fromJsonEn(Map<String, dynamic> json) {
    return AboutModel(
      aboutPf: json['aboutPfen'] as String,
      aboutPs: json['aboutPsen'] as String,
      principles: json['principlesen'] as String,
      mission: json['missionen'] as String,
      vision: json['visionen'] as String,
    );
  }

  factory AboutModel.fromJsonAr(Map<String, dynamic> json) {
    return AboutModel(
      aboutPf: json['aboutPfar'] as String,
      aboutPs: json['aboutPsar'] as String,
      principles: json['principlesar'] as String,
      mission: json['missionar'] as String,
      vision: json['visionar'] as String,
    );
  }

  factory AboutModel.fromJsonUr(Map<String, dynamic> json) {
    return AboutModel(
      aboutPf: json['aboutPfor'] as String,
      aboutPs: json['aboutPsor'] as String,
      principles: json['principlesor'] as String,
      mission: json['missionor'] as String,
      vision: json['visionor'] as String,
    );
  }

  factory AboutModel.fromJsonFil(Map<String, dynamic> json) {
    return AboutModel(
      aboutPf: json['aboutPffl'] as String,
      aboutPs: json['aboutPsfl'] as String,
      principles: json['principlesfl'] as String,
      mission: json['missionfl'] as String,
      vision: json['visionfl'] as String,
    );
  }
}
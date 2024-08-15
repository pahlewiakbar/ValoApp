// To parse this JSON data, do
//
//     final modeModel = modeModelFromJson(jsonString);

import 'dart:convert';

ModeModel modeModelFromJson(String str) => ModeModel.fromJson(json.decode(str));

String modeModelToJson(ModeModel data) => json.encode(data.toJson());

class ModeModel {
  final String uuid;
  String? displayName;
  String? duration;
  String? displayIcon;

  ModeModel({
    required this.uuid,
    this.displayName,
    this.duration,
    this.displayIcon,
  });

  factory ModeModel.fromJson(Map<String, dynamic> json) => ModeModel(
        uuid: json["uuid"],
        displayName: json["displayName"],
        duration: json["duration"],
        displayIcon: json["displayIcon"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "duration": duration,
        "displayIcon": displayIcon,
      };
}

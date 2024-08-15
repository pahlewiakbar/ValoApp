// To parse this JSON data, do
//
//     final mapsModel = mapsModelFromJson(jsonString);

import 'dart:convert';

MapsModel mapsModelFromJson(String str) => MapsModel.fromJson(json.decode(str));

String mapsModelToJson(MapsModel data) => json.encode(data.toJson());

class MapsModel {
  final String uuid;
  String? displayName;
  String? coordinates;
  String? displayIcon;
  String? splash;

  MapsModel({
    required this.uuid,
    this.displayName,
    this.coordinates,
    this.displayIcon,
    this.splash,
  });

  factory MapsModel.fromJson(Map<String, dynamic> json) => MapsModel(
        uuid: json["uuid"],
        displayName: json["displayName"],
        coordinates: json["coordinates"],
        displayIcon: json["displayIcon"],
        splash: json["splash"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "coordinates": coordinates,
        "displayIcon": displayIcon,
        "splash": splash,
      };
}

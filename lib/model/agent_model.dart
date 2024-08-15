// To parse this JSON data, do
//
//     final agentModel = agentModelFromJson(jsonString);

import 'dart:convert';

AgentModel agentModelFromJson(String str) =>
    AgentModel.fromJson(json.decode(str));

String agentModelToJson(AgentModel data) => json.encode(data.toJson());

class AgentModel {
  final String uuid;
  String? displayName;
  String? description;
  String? displayIcon;
  String? fullPortrait;
  List<String>? backgroundGradientColors;
  Role? role;
  List<Ability>? abilities;

  AgentModel({
    required this.uuid,
    this.displayName,
    this.description,
    this.displayIcon,
    this.fullPortrait,
    this.backgroundGradientColors,
    this.role,
    this.abilities,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
        uuid: json["uuid"],
        displayName: json["displayName"],
        description: json["description"],
        displayIcon: json["displayIcon"],
        fullPortrait: json["fullPortrait"],
        backgroundGradientColors: json["backgroundGradientColors"] == null
            ? []
            : List<String>.from(
                json["backgroundGradientColors"]!.map((x) => x)),
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        abilities: json["abilities"] == null
            ? []
            : List<Ability>.from(
                json["abilities"]!.map((x) => Ability.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "description": description,
        "displayIcon": displayIcon,
        "fullPortrait": fullPortrait,
        "backgroundGradientColors": backgroundGradientColors == null
            ? []
            : List<dynamic>.from(backgroundGradientColors!.map((x) => x)),
        "role": role?.toJson(),
        "abilities": abilities == null
            ? []
            : List<dynamic>.from(abilities!.map((x) => x.toJson())),
      };
}

class Ability {
  final String? slot;
  final String? displayName;
  final String? description;
  final String? displayIcon;

  Ability({
    this.slot,
    this.displayName,
    this.description,
    this.displayIcon,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        slot: json["slot"],
        displayName: json["displayName"],
        description: json["description"],
        displayIcon: json["displayIcon"],
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "displayName": displayName,
        "description": description,
        "displayIcon": displayIcon,
      };
}

class Role {
  final String? uuid;
  final String? displayName;
  final String? description;
  final String? displayIcon;
  final String? assetPath;

  Role({
    this.uuid,
    this.displayName,
    this.description,
    this.displayIcon,
    this.assetPath,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        uuid: json["uuid"],
        displayName: json["displayName"],
        description: json["description"],
        displayIcon: json["displayIcon"],
        assetPath: json["assetPath"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "description": description,
        "displayIcon": displayIcon,
        "assetPath": assetPath,
      };
}

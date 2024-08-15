// To parse this JSON data, do
//
//     final weaponModel = weaponModelFromJson(jsonString);

import 'dart:convert';

WeaponModel weaponModelFromJson(String str) =>
    WeaponModel.fromJson(json.decode(str));

String weaponModelToJson(WeaponModel data) => json.encode(data.toJson());

class WeaponModel {
  final String uuid;
  String? displayName;
  String? displayIcon;
  ShopData? shopData;

  WeaponModel({
    required this.uuid,
    this.displayName,
    this.displayIcon,
    this.shopData,
  });

  factory WeaponModel.fromJson(Map<String, dynamic> json) => WeaponModel(
        uuid: json["uuid"],
        displayName: json["displayName"],
        displayIcon: json["displayIcon"],
        shopData: json["shopData"] == null
            ? null
            : ShopData.fromJson(json["shopData"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "displayName": displayName,
        "displayIcon": displayIcon,
        "shopData": shopData?.toJson(),
      };
}

class ShopData {
  final int? cost;
  final String? category;

  ShopData({
    this.cost,
    this.category,
  });

  factory ShopData.fromJson(Map<String, dynamic> json) => ShopData(
        cost: json["cost"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "cost": cost,
        "category": category,
      };
}

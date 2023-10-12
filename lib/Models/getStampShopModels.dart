// To parse this JSON data, do
//
//     final getStampShopModels = getStampShopModelsFromJson(jsonString);

import 'dart:convert';

GetStampShopModels getStampShopModelsFromJson(String str) =>
    GetStampShopModels.fromJson(json.decode(str));

String getStampShopModelsToJson(GetStampShopModels data) =>
    json.encode(data.toJson());

class GetStampShopModels {
  String? status;
  List<Datum>? data;

  GetStampShopModels({
    this.status,
    this.data,
  });

factory GetStampShopModels.fromJson(Map<String, dynamic> json) =>
    GetStampShopModels(
      status: json["status"],
      data: json["data"] != null
          ? List<Datum>.from((json["data"] as List).map((x) => Datum.fromJson(x)))
          : null,
    );


  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? stampsPacksId;
  String? stampsPacksName;
  String? stampsPacksImage;
  String? stampsPacksPrice;
  DateTime? dateAdded;
  String? status;

  Datum({
    this.stampsPacksId,
    this.stampsPacksName,
    this.stampsPacksImage,
    this.stampsPacksPrice,
    this.dateAdded,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        stampsPacksId: json["stamps_packs_id"],
        stampsPacksName: json["stamps_packs_name"],
        stampsPacksImage: json["stamps_packs_image"],
        stampsPacksPrice: json["stamps_packs_price"],
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "stamps_packs_id": stampsPacksId,
        "stamps_packs_name": stampsPacksName,
        "stamps_packs_image": stampsPacksImage,
        "stamps_packs_price": stampsPacksPrice,
        "date_added": dateAdded!.toIso8601String(),
        "status": status,
      };
}

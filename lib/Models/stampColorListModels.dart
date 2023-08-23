// To parse this JSON data, do
//
//     final StampColorListModels = StampColorListModelsFromJson(jsonString);

import 'dart:convert';

StampColorListModels StampColorListModelsFromJson(String str) =>
    StampColorListModels.fromJson(json.decode(str));

String StampColorListModelsToJson(StampColorListModels data) =>
    json.encode(data.toJson());

class StampColorListModels {
  String? status;
  List<Datum>? data;

  StampColorListModels({
    this.status,
    this.data,
  });

  factory StampColorListModels.fromJson(Map<String, dynamic> json) =>
      StampColorListModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? stampsColorId;
  String? stampsColor;
  String? stampsColorRgb;
  String? stampsColorImage;
  String? isCancelled;
  String? status;
  DateTime? dateAdded;

  Datum({
    this.stampsColorId,
    this.stampsColor,
    this.stampsColorRgb,
    this.stampsColorImage,
    this.isCancelled,
    this.status,
    this.dateAdded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        stampsColorId: json["stamps_color_id"],
        stampsColor: json["stamps_color"],
        stampsColorRgb: json["stamps_color_rgb"],
        stampsColorImage: json["stamps_color_image"],
        isCancelled: json["is_cancelled"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "stamps_color_id": stampsColorId,
        "stamps_color": stampsColor,
        "stamps_color_rgb": stampsColorRgb,
        "stamps_color_image": stampsColorImage,
        "is_cancelled": isCancelled,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
      };
}

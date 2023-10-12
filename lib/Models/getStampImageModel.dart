// To parse this JSON data, do
//
//     final getStampImageModels = getStampImageModelsFromJson(jsonString);

import 'dart:convert';

GetStampImageModels getStampImageModelsFromJson(String str) =>
    GetStampImageModels.fromJson(json.decode(str));

String getStampImageModelsToJson(GetStampImageModels data) =>
    json.encode(data.toJson());

class GetStampImageModels {
  String? status;
  List<Datum>? data;

  GetStampImageModels({
    this.status,
    this.data,
  });

  factory GetStampImageModels.fromJson(Map<String, dynamic> json) =>
      GetStampImageModels(
        status: json["status"],
       data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))): null, 




      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? stampShapeId;
  String? stampShape;
  String? stampShapeImage;
  String? isCancelled;
  DateTime? dateAdded;
  String? actions;

  Datum({
    this.stampShapeId,
    this.stampShape,
    this.stampShapeImage,
    this.isCancelled,
    this.dateAdded,
    this.actions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        stampShapeId: json["stamp_shape_id"],
        stampShape: json["stamp_shape"],
        stampShapeImage: json["stamp_shape_image"],
        isCancelled: json["is_cancelled"],
        dateAdded: DateTime.parse(json["date_added"]),
        actions: json["actions"],
      );

  Map<String, dynamic> toJson() => {
        "stamp_shape_id": stampShapeId,
        "stamp_shape": stampShape,
        "stamp_shape_image": stampShapeImage,
        "is_cancelled": isCancelled,
        "date_added": dateAdded!.toIso8601String(),
        "actions": actions,
      };
}

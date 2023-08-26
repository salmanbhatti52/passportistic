// To parse this JSON data, do
//
//     final getGenderListModels = getGenderListModelsFromJson(jsonString);

import 'dart:convert';

GetGenderListModels getGenderListModelsFromJson(String str) =>
    GetGenderListModels.fromJson(json.decode(str));

String getGenderListModelsToJson(GetGenderListModels data) =>
    json.encode(data.toJson());

class GetGenderListModels {
  String? status;
  List<Datum>? data;

  GetGenderListModels({
    this.status,
    this.data,
  });

  factory GetGenderListModels.fromJson(Map<String, dynamic> json) =>
      GetGenderListModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? genderId;
  String? gender;
  DateTime? dateAdded;
  String? isCancelled;
  String? actions;

  Datum({
    this.genderId,
    this.gender,
    this.dateAdded,
    this.isCancelled,
    this.actions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        genderId: json["gender_id"],
        gender: json["gender"],
        dateAdded: DateTime.parse(json["date_added"]),
        isCancelled: json["is_cancelled"],
        actions: json["actions"],
      );

  Map<String, dynamic> toJson() => {
        "gender_id": genderId,
        "gender": gender,
        "date_added": dateAdded!.toIso8601String(),
        "is_cancelled": isCancelled,
        "actions": actions,
      };
}

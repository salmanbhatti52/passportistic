// To parse this JSON data, do
//
//     final validationModelApi = validationModelApiFromJson(jsonString);

import 'dart:convert';

ValidationModelApi validationModelApiFromJson(String str) =>
    ValidationModelApi.fromJson(json.decode(str));

String validationModelApiToJson(ValidationModelApi data) =>
    json.encode(data.toJson());

class ValidationModelApi {
  int? code;
  String? status;
  Data? data;

  ValidationModelApi({
    this.code,
    this.status,
    this.data,
  });

  factory ValidationModelApi.fromJson(Map<String, dynamic> json) =>
      ValidationModelApi(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  int? totalStamps;
  int? totalPages;
  String? itineraryAccess;
  String? diaryAccess;

  Data({
    this.totalStamps,
    this.totalPages,
    this.itineraryAccess,
    this.diaryAccess,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalStamps: json["total_stamps"],
        totalPages: json["total_pages"],
        itineraryAccess: json["itinerary_access"],
        diaryAccess: json["diary_access"],
      );

  Map<String, dynamic> toJson() => {
        "total_stamps": totalStamps,
        "total_pages": totalPages,
        "itinerary_access": itineraryAccess,
        "diary_access": diaryAccess,
      };
}

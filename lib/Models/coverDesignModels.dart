// To parse this JSON data, do
//
//     final coverDesignDataModel = coverDesignDataModelFromJson(jsonString);

import 'dart:convert';

CoverDesignDataModel coverDesignDataModelFromJson(String str) =>
    CoverDesignDataModel.fromJson(json.decode(str));

String coverDesignDataModelToJson(CoverDesignDataModel data) =>
    json.encode(data.toJson());

class CoverDesignDataModel {
  String? status;
  List<Datum>? data;

  CoverDesignDataModel({
    this.status,
    this.data,
  });

  factory CoverDesignDataModel.fromJson(Map<String, dynamic> json) =>
      CoverDesignDataModel(
        status: json["status"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? passportDesignId;
  String? passportCountry;
  String? passportFrontCover;
  String? passportDataDesign;
  String? passportLegalDesign;
  DateTime? dateAdded;
  String? isCancalled;
  String? actions;

  Datum({
    this.passportDesignId,
    this.passportCountry,
    this.passportFrontCover,
    this.passportDataDesign,
    this.passportLegalDesign,
    this.dateAdded,
    this.isCancalled,
    this.actions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        passportDesignId: json["passport_design_id"],
        passportCountry: json["passport_country"],
        passportFrontCover: json["passport_front_cover"],
        passportDataDesign: json["passport_data_design"],
        passportLegalDesign: json["passport_legal_design"],
        dateAdded: DateTime.parse(json["date_added"]),
        isCancalled: json["is_cancalled"],
        actions: json["actions"],
      );

  Map<String, dynamic> toJson() => {
        "passport_design_id": passportDesignId,
        "passport_country": passportCountry,
        "passport_front_cover": passportFrontCover,
        "passport_data_design": passportDataDesign,
        "passport_legal_design": passportLegalDesign,
        "date_added": dateAdded!.toIso8601String(),
        "is_cancalled": isCancalled,
        "actions": actions,
      };
}

// To parse this JSON data, do
//
//     final getCountryListModels = getCountryListModelsFromJson(jsonString);

import 'dart:convert';

GetCountryListModels getCountryListModelsFromJson(String str) =>
    GetCountryListModels.fromJson(json.decode(str));

String getCountryListModelsToJson(GetCountryListModels data) =>
    json.encode(data.toJson());

class GetCountryListModels {
  String? status;
  List<Datum>? data;

  GetCountryListModels({
    this.status,
    this.data,
  });

  factory GetCountryListModels.fromJson(Map<String, dynamic> json) =>
      GetCountryListModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? passportDesignId;
  String? passportCountry;
  String? legalNotice;
  String? passportFrontCover;
  String? passportDataDesign;
  String? passportLegalDesign;
  DateTime? dateAdded;
  IsCancalled? isCancalled;
  Status? status;

  Datum({
    this.passportDesignId,
    this.passportCountry,
    this.legalNotice,
    this.passportFrontCover,
    this.passportDataDesign,
    this.passportLegalDesign,
    this.dateAdded,
    this.isCancalled,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        passportDesignId: json["passport_design_id"],
        passportCountry: json["passport_country"],
        legalNotice: json["legal_notice"],
        passportFrontCover: json["passport_front_cover"],
        passportDataDesign: json["passport_data_design"],
        passportLegalDesign: json["passport_legal_design"],
        dateAdded: DateTime.parse(json["date_added"]),
        isCancalled: isCancalledValues.map[json["is_cancalled"]],
        status: statusValues.map[json["status"]],
      );

  Map<String, dynamic> toJson() => {
        "passport_design_id": passportDesignId,
        "passport_country": passportCountry,
        "legal_notice": legalNotice,
        "passport_front_cover": passportFrontCover,
        "passport_data_design": passportDataDesign,
        "passport_legal_design": passportLegalDesign,
        "date_added": dateAdded!.toIso8601String(),
        "is_cancalled": isCancalledValues.reverse[isCancalled],
        "status": statusValues.reverse[status],
      };
}

enum IsCancalled { FALSE }

final isCancalledValues = EnumValues({"False": IsCancalled.FALSE});

enum Status { ACTIVE }

final statusValues = EnumValues({"Active": Status.ACTIVE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

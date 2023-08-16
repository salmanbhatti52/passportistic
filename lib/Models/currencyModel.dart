// To parse this JSON data, do
//
//     final currencyModel = currencyModelFromJson(jsonString);

import 'dart:convert';

CurrencyModel currencyModelFromJson(String str) =>
    CurrencyModel.fromJson(json.decode(str));

String currencyModelToJson(CurrencyModel data) => json.encode(data.toJson());

class CurrencyModel {
  String? status;
  String? message;
  List<Datum>? data;

  CurrencyModel({
    this.status,
    this.message,
    this.data,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? currencyId;
  String? currencyCode;
  DateTime? dateAdded;
  String? actions;

  Datum({
    this.currencyId,
    this.currencyCode,
    this.dateAdded,
    this.actions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        currencyId: json["currency_id"],
        currencyCode: json["currency_code"],
        dateAdded: DateTime.parse(json["date_added"]),
        actions: json["actions"],
      );

  Map<String, dynamic> toJson() => {
        "currency_id": currencyId,
        "currency_code": currencyCode,
        "date_added": dateAdded!.toIso8601String(),
        "actions": actions,
      };
}

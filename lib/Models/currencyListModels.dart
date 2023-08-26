// To parse this JSON data, do
//
//     final getCurrencyListModels = getCurrencyListModelsFromJson(jsonString);

import 'dart:convert';

GetCurrencyListModels getCurrencyListModelsFromJson(String str) => GetCurrencyListModels.fromJson(json.decode(str));

String getCurrencyListModelsToJson(GetCurrencyListModels data) => json.encode(data.toJson());

class GetCurrencyListModels {
    String? status;
    List<Datum>? data;

    GetCurrencyListModels({
        this.status,
        this.data,
    });

    factory GetCurrencyListModels.fromJson(Map<String, dynamic> json) => GetCurrencyListModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
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

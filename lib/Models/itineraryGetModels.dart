// To parse this JSON data, do
//
//     final iteneraryGetModels = iteneraryGetModelsFromJson(jsonString);

import 'dart:convert';

IteneraryGetModels iteneraryGetModelsFromJson(String str) =>
    IteneraryGetModels.fromJson(json.decode(str));

String iteneraryGetModelsToJson(IteneraryGetModels data) =>
    json.encode(data.toJson());

class IteneraryGetModels {
  String? status;
  List<Datum>? data;

  IteneraryGetModels({
    this.status,
    this.data,
  });

  factory IteneraryGetModels.fromJson(Map<String, dynamic> json) =>
      IteneraryGetModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? travelLtineraryId;
  String? passportHolderId;
  String? travelLtineraryName;
  DateTime? travelLtineraryDepartDate;
  DateTime? travelLtineraryArriveDate;
  IsCancelled? isCancelled;
  Status? status;
  DateTime? dateAdded;

  Datum({
    this.travelLtineraryId,
    this.passportHolderId,
    this.travelLtineraryName,
    this.travelLtineraryDepartDate,
    this.travelLtineraryArriveDate,
    this.isCancelled,
    this.status,
    this.dateAdded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        travelLtineraryId: json["travel_ltinerary_id"],
        passportHolderId: json["passport_holder_id"],
        travelLtineraryName: json["travel_ltinerary_name"],
        travelLtineraryDepartDate:
            DateTime.parse(json["travel_ltinerary_depart_date"]),
        travelLtineraryArriveDate:
            DateTime.parse(json["travel_ltinerary_arrive_date"]),
        isCancelled: isCancelledValues.map[json["is_cancelled"]],
        status: statusValues.map[json["status"]],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "travel_ltinerary_id": travelLtineraryId,
        "passport_holder_id": passportHolderId,
        "travel_ltinerary_name": travelLtineraryName,
        "travel_ltinerary_depart_date":
            "${travelLtineraryDepartDate!.year.toString().padLeft(4, '0')}-${travelLtineraryDepartDate!.month.toString().padLeft(2, '0')}-${travelLtineraryDepartDate!.day.toString().padLeft(2, '0')}",
        "travel_ltinerary_arrive_date":
            "${travelLtineraryArriveDate!.year.toString().padLeft(4, '0')}-${travelLtineraryArriveDate!.month.toString().padLeft(2, '0')}-${travelLtineraryArriveDate!.day.toString().padLeft(2, '0')}",
        "is_cancelled": isCancelledValues.reverse[isCancelled],
        "status": statusValues.reverse[status],
        "date_added": dateAdded!.toIso8601String(),
      };
}

enum IsCancelled { FALSE }

final isCancelledValues = EnumValues({"False": IsCancelled.FALSE});

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

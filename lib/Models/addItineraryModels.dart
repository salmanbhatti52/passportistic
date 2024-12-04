// To parse this JSON data, do
//
//     final itinerayAddModels = itinerayAddModelsFromJson(jsonString);

import 'dart:convert';

ItinerayAddModels itinerayAddModelsFromJson(String str) =>
    ItinerayAddModels.fromJson(json.decode(str));

String itinerayAddModelsToJson(ItinerayAddModels data) =>
    json.encode(data.toJson());

class ItinerayAddModels {
  String? status;
  String? message;
  List<Datum>? data;

  ItinerayAddModels({
    this.status,
    this.message,
    this.data,
  });

  factory ItinerayAddModels.fromJson(Map<String, dynamic> json) =>
      ItinerayAddModels(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
    "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? travelLtineraryId;
  String? passportHolderId;
  String? travelLtineraryName;
  DateTime? travelLtineraryDepartDate;
  DateTime? travelLtineraryArriveDate;
  String? isCancelled;
  String? status;
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
        isCancelled: json["is_cancelled"],
        status: json["status"],
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
        "is_cancelled": isCancelled,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
      };
}

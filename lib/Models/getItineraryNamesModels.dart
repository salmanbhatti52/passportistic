// To parse this JSON data, do
//
//     final getItineraryModels = getItineraryModelsFromJson(jsonString);

import 'dart:convert';

GetItineraryModels getItineraryModelsFromJson(String str) =>
    GetItineraryModels.fromJson(json.decode(str));

String getItineraryModelsToJson(GetItineraryModels data) =>
    json.encode(data.toJson());

class GetItineraryModels {
  String? status;
  Data? data;

  GetItineraryModels({
    this.status,
    this.data,
  });

  factory GetItineraryModels.fromJson(Map<String, dynamic> json) =>
      GetItineraryModels(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  String? travelLtineraryId;
  String? passportHolderId;
  String? travelLtineraryName;
  DateTime? travelLtineraryDepartDate;
  DateTime? travelLtineraryArriveDate;
  String? isCancelled;
  String? status;
  DateTime? dateAdded;

  Data({
    this.travelLtineraryId,
    this.passportHolderId,
    this.travelLtineraryName,
    this.travelLtineraryDepartDate,
    this.travelLtineraryArriveDate,
    this.isCancelled,
    this.status,
    this.dateAdded,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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

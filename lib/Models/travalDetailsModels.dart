// To parse this JSON data, do
//
//     final travalDetailsModels = travalDetailsModelsFromJson(jsonString);

import 'dart:convert';

TravalDetailsModels travalDetailsModelsFromJson(String str) =>
    TravalDetailsModels.fromJson(json.decode(str));

String travalDetailsModelsToJson(TravalDetailsModels data) =>
    json.encode(data.toJson());

class TravalDetailsModels {
  String? status;
  String? message;
  List<Datum>? data;

  TravalDetailsModels({
    this.status,
    this.message,
    this.data,
  });

  factory TravalDetailsModels.fromJson(Map<String, dynamic> json) =>
      TravalDetailsModels(
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
  String? factLtravelLtineraryTravelId;
  String? travelLtineraryId;
  String? passportHolderId;
  String? travelDayNumber;
  String? transportModeId;
  String? travelDepartCity;
  String? travelDepartTripDetails;
  String? departureTime;
  DateTime? departureDate;
  String? tripTravelTime;
  String? travelArriveCity;
  String? arrivalTime;
  DateTime? arrivalDate;
  String? layoverTime;
  String? isCancelled;
  String? status;
  DateTime? dateAdded;

  Datum({
    this.factLtravelLtineraryTravelId,
    this.travelLtineraryId,
    this.passportHolderId,
    this.travelDayNumber,
    this.transportModeId,
    this.travelDepartCity,
    this.travelDepartTripDetails,
    this.departureTime,
    this.departureDate,
    this.tripTravelTime,
    this.travelArriveCity,
    this.arrivalTime,
    this.arrivalDate,
    this.layoverTime,
    this.isCancelled,
    this.status,
    this.dateAdded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        factLtravelLtineraryTravelId: json["fact_ltravel_ltinerary_travel_id"],
        travelLtineraryId: json["travel_ltinerary_id"],
        passportHolderId: json["passport_holder_id"],
        travelDayNumber: json["travel_day_number"],
        transportModeId: json["transport_mode_id"],
        travelDepartCity: json["travel_depart_city"],
        travelDepartTripDetails: json["travel_depart_trip_details"],
        departureTime: json["departure_time"],
        departureDate: DateTime.parse(json["departure_date"]),
        tripTravelTime: json["trip_travel_time"],
        travelArriveCity: json["travel_arrive_city"],
        arrivalTime: json["arrival_time"],
        arrivalDate: DateTime.parse(json["arrival_date"]),
        layoverTime: json["layover_time"],
        isCancelled: json["is_cancelled"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "fact_ltravel_ltinerary_travel_id": factLtravelLtineraryTravelId,
        "travel_ltinerary_id": travelLtineraryId,
        "passport_holder_id": passportHolderId,
        "travel_day_number": travelDayNumber,
        "transport_mode_id": transportModeId,
        "travel_depart_city": travelDepartCity,
        "travel_depart_trip_details": travelDepartTripDetails,
        "departure_time": departureTime,
        "departure_date":
            "${departureDate!.year.toString().padLeft(4, '0')}-${departureDate!.month.toString().padLeft(2, '0')}-${departureDate!.day.toString().padLeft(2, '0')}",
        "trip_travel_time": tripTravelTime,
        "travel_arrive_city": travelArriveCity,
        "arrival_time": arrivalTime,
        "arrival_date":
            "${arrivalDate!.year.toString().padLeft(4, '0')}-${arrivalDate!.month.toString().padLeft(2, '0')}-${arrivalDate!.day.toString().padLeft(2, '0')}",
        "layover_time": layoverTime,
        "is_cancelled": isCancelled,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
      };
}

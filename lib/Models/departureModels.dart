// To parse this JSON data, do
//
//     final departureModel = departureModelFromJson(jsonString);

import 'dart:convert';

DepartureModel departureModelFromJson(String str) => DepartureModel.fromJson(json.decode(str));

String departureModelToJson(DepartureModel data) => json.encode(data.toJson());

class DepartureModel {
    String? status;
    List<Datum>? data;

    DepartureModel({
        this.status,
        this.data,
    });

    factory DepartureModel.fromJson(Map<String, dynamic> json) => DepartureModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? departureDetailsId;
    String? country;
    String? cityName;
    String? transportMode;
    String? stampShape;
    String? stampColor;
    DateTime? departureDate;
    String? departureTime;
    String? stampLocation;
    DateTime? dateAdded;
    String? status;

    Datum({
        this.departureDetailsId,
        this.country,
        this.cityName,
        this.transportMode,
        this.stampShape,
        this.stampColor,
        this.departureDate,
        this.departureTime,
        this.stampLocation,
        this.dateAdded,
        this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        departureDetailsId: json["departure_details-id"],
        country: json["country"],
        cityName: json["city_name"],
        transportMode: json["transport_mode"],
        stampShape: json["stamp_shape"],
        stampColor: json["stamp_color"],
        departureDate: DateTime.parse(json["departure_date"]),
        departureTime: json["departure_time"],
        stampLocation: json["stamp_location"],
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "departure_details-id": departureDetailsId,
        "country": country,
        "city_name": cityName,
        "transport_mode": transportMode,
        "stamp_shape": stampShape,
        "stamp_color": stampColor,
        "departure_date": "${departureDate!.year.toString().padLeft(4, '0')}-${departureDate!.month.toString().padLeft(2, '0')}-${departureDate!.day.toString().padLeft(2, '0')}",
        "departure_time": departureTime,
        "stamp_location": stampLocation,
        "date_added": dateAdded!.toIso8601String(),
        "status": status,
    };
}

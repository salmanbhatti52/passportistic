// To parse this JSON data, do
//
//     final accommodationModels = accommodationModelsFromJson(jsonString);

import 'dart:convert';

AccommodationModels accommodationModelsFromJson(String str) =>
    AccommodationModels.fromJson(json.decode(str));

String accommodationModelsToJson(AccommodationModels data) =>
    json.encode(data.toJson());

class AccommodationModels {
  String? status;
  String? message;
  List<Datum>? data;

  AccommodationModels({
    this.status,
    this.message,
    this.data,
  });

  factory AccommodationModels.fromJson(Map<String, dynamic> json) =>
      AccommodationModels(
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
  String? factTravelLtineraryAccomodationId;
  String? travelLtineraryId;
  String? passportHolderId;
  String? accomodationCity;
  String? accomodationName;
  String? accomodationType;
  String? accomodationAddress;
  DateTime? accomodationCheckinDate;
  dynamic accomodationCheckoutTime;
  dynamic accomodationCheckinTime;
  DateTime? accomodationCheckoutDate;
  String? accomodationNights;
  String? accomodationBreakfast;
  IsCancelled? isCancelled;
  Status? status;
  DateTime? dateAdded;

  Datum({
    this.factTravelLtineraryAccomodationId,
    this.travelLtineraryId,
    this.passportHolderId,
    this.accomodationCity,
    this.accomodationName,
    this.accomodationType,
    this.accomodationAddress,
    this.accomodationCheckinDate,
    this.accomodationCheckoutTime,
    this.accomodationCheckinTime,
    this.accomodationCheckoutDate,
    this.accomodationNights,
    this.accomodationBreakfast,
    this.isCancelled,
    this.status,
    this.dateAdded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        factTravelLtineraryAccomodationId:
            json["fact_travel_ltinerary_accomodation_id"],
        travelLtineraryId: json["travel_ltinerary_id"],
        passportHolderId: json["passport_holder_id"],
        accomodationCity: json["accomodation_city"],
        accomodationName: json["accomodation_name"],
        accomodationType: json["accomodation_type"],
        accomodationAddress: json["accomodation_address"],
        accomodationCheckinDate:
            DateTime.parse(json["accomodation_checkin_date"]),
        accomodationCheckoutTime: json["accomodation_checkout_time"],
        accomodationCheckinTime: json["accomodation_checkin_time"],
        accomodationCheckoutDate:
            DateTime.parse(json["accomodation_checkout_date"]),
        accomodationNights: json["accomodation_nights"],
        accomodationBreakfast: json["accomodation_breakfast"],
        isCancelled: isCancelledValues.map[json["is_cancelled"]],
        status: statusValues.map[json["status"]],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "fact_travel_ltinerary_accomodation_id":
            factTravelLtineraryAccomodationId,
        "travel_ltinerary_id": travelLtineraryId,
        "passport_holder_id": passportHolderId,
        "accomodation_city": accomodationCity,
        "accomodation_name": accomodationName,
        "accomodation_type": accomodationType,
        "accomodation_address": accomodationAddress,
        "accomodation_checkin_date":
            "${accomodationCheckinDate!.year.toString().padLeft(4, '0')}-${accomodationCheckinDate!.month.toString().padLeft(2, '0')}-${accomodationCheckinDate!.day.toString().padLeft(2, '0')}",
        "accomodation_checkout_time": accomodationCheckoutTime,
        "accomodation_checkin_time": accomodationCheckinTime,
        "accomodation_checkout_date":
            "${accomodationCheckoutDate!.year.toString().padLeft(4, '0')}-${accomodationCheckoutDate!.month.toString().padLeft(2, '0')}-${accomodationCheckoutDate!.day.toString().padLeft(2, '0')}",
        "accomodation_nights": accomodationNights,
        "accomodation_breakfast": accomodationBreakfast,
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

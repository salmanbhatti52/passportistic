// To parse this JSON data, do
//
//     final getAccomodationsDetailsModels = getAccomodationsDetailsModelsFromJson(jsonString);

import 'dart:convert';

GetAccomodationsDetailsModels getAccomodationsDetailsModelsFromJson(String str) => GetAccomodationsDetailsModels.fromJson(json.decode(str));

String getAccomodationsDetailsModelsToJson(GetAccomodationsDetailsModels data) => json.encode(data.toJson());

class GetAccomodationsDetailsModels {
    String? status;
    List<Datum>? data;

    GetAccomodationsDetailsModels({
        this.status,
        this.data,
    });

    factory GetAccomodationsDetailsModels.fromJson(Map<String, dynamic> json) => GetAccomodationsDetailsModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
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
    DateTime? accomodationCheckoutDate;
    String? accomodationNights;
    String? accomodationBreakfast;
    String? isCancelled;
    String? status;
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
        this.accomodationCheckoutDate,
        this.accomodationNights,
        this.accomodationBreakfast,
        this.isCancelled,
        this.status,
        this.dateAdded,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        factTravelLtineraryAccomodationId: json["fact_travel_ltinerary_accomodation_id"],
        travelLtineraryId: json["travel_ltinerary_id"],
        passportHolderId: json["passport_holder_id"],
        accomodationCity: json["accomodation_city"],
        accomodationName: json["accomodation_name"],
        accomodationType: json["accomodation_type"],
        accomodationAddress: json["accomodation_address"],
        accomodationCheckinDate: DateTime.parse(json["accomodation_checkin_date"]),
        accomodationCheckoutDate: DateTime.parse(json["accomodation_checkout_date"]),
        accomodationNights: json["accomodation_nights"],
        accomodationBreakfast: json["accomodation_breakfast"],
        isCancelled: json["is_cancelled"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "fact_travel_ltinerary_accomodation_id": factTravelLtineraryAccomodationId,
        "travel_ltinerary_id": travelLtineraryId,
        "passport_holder_id": passportHolderId,
        "accomodation_city": accomodationCity,
        "accomodation_name": accomodationName,
        "accomodation_type": accomodationType,
        "accomodation_address": accomodationAddress,
        "accomodation_checkin_date": "${accomodationCheckinDate!.year.toString().padLeft(4, '0')}-${accomodationCheckinDate!.month.toString().padLeft(2, '0')}-${accomodationCheckinDate!.day.toString().padLeft(2, '0')}",
        "accomodation_checkout_date": "${accomodationCheckoutDate!.year.toString().padLeft(4, '0')}-${accomodationCheckoutDate!.month.toString().padLeft(2, '0')}-${accomodationCheckoutDate!.day.toString().padLeft(2, '0')}",
        "accomodation_nights": accomodationNights,
        "accomodation_breakfast": accomodationBreakfast,
        "is_cancelled": isCancelled,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
    };
}

// To parse this JSON data, do
//
//     final departedDetailsModels = departedDetailsModelsFromJson(jsonString);

import 'dart:convert';

DepartedDetailsModels departedDetailsModelsFromJson(String str) =>
    DepartedDetailsModels.fromJson(json.decode(str));

String departedDetailsModelsToJson(DepartedDetailsModels data) =>
    json.encode(data.toJson());

class DepartedDetailsModels {
  String? status;
  String? message;
  List<Datum>? data;

  DepartedDetailsModels({
    this.status,
    this.message,
    this.data,
  });

  factory DepartedDetailsModels.fromJson(Map<String, dynamic> json) =>
      DepartedDetailsModels(
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
  String? stampsId;
  String? passportHolderId;
  StampsArriveDepart? stampsArriveDepart;
  String? transportModeId;
  String? stampShapeId;
  String? stampsColorId;
  String? stampImage;
  String? stampsOffsetRotation;
  String? stampsOffsetHorizental;
  String? stampsOffsetVertical;
  String? stampsPageNumber;
  String? stampsPositionNumber;
  StampsCountry? stampsCountry;
  StampsCity? stampsCity;
  IsCancelled? isCancelled;
  DateTime? stampsDate;
  String? stampsTime;
  Status? status;
  DateTime? dateAdded;

  Datum({
    this.stampsId,
    this.passportHolderId,
    this.stampsArriveDepart,
    this.transportModeId,
    this.stampShapeId,
    this.stampsColorId,
    this.stampImage,
    this.stampsOffsetRotation,
    this.stampsOffsetHorizental,
    this.stampsOffsetVertical,
    this.stampsPageNumber,
    this.stampsPositionNumber,
    this.stampsCountry,
    this.stampsCity,
    this.isCancelled,
    this.stampsDate,
    this.stampsTime,
    this.status,
    this.dateAdded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        stampsId: json["stamps_id"],
        passportHolderId: json["passport_holder_id"],
        stampsArriveDepart:
            stampsArriveDepartValues.map[json["stamps_arrive_depart"]],
        transportModeId: json["transport_mode_id"],
        stampShapeId: json["stamp_shape_id"],
        stampsColorId: json["stamps_color_id"],
        stampImage: json["stamp_image"],
        stampsOffsetRotation: json["stamps_offset_rotation"],
        stampsOffsetHorizental: json["stamps_offset_horizental"],
        stampsOffsetVertical: json["stamps_offset_vertical"],
        stampsPageNumber: json["stamps_page_number"],
        stampsPositionNumber: json["stamps_position_number"],
        stampsCountry: stampsCountryValues.map[json["stamps_country"]],
        stampsCity: stampsCityValues.map[json["stamps_city"]],
        isCancelled: isCancelledValues.map[json["is_cancelled"]],
        stampsDate: DateTime.parse(json["stamps_date"]),
        stampsTime: json["stamps_time"],
        status: statusValues.map[json["status"]],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "stamps_id": stampsId,
        "passport_holder_id": passportHolderId,
        "stamps_arrive_depart":
            stampsArriveDepartValues.reverse[stampsArriveDepart],
        "transport_mode_id": transportModeId,
        "stamp_shape_id": stampShapeId,
        "stamps_color_id": stampsColorId,
        "stamp_image": stampImage,
        "stamps_offset_rotation": stampsOffsetRotation,
        "stamps_offset_horizental": stampsOffsetHorizental,
        "stamps_offset_vertical": stampsOffsetVertical,
        "stamps_page_number": stampsPageNumber,
        "stamps_position_number": stampsPositionNumber,
        "stamps_country": stampsCountryValues.reverse[stampsCountry],
        "stamps_city": stampsCityValues.reverse[stampsCity],
        "is_cancelled": isCancelledValues.reverse[isCancelled],
        "stamps_date":
            "${stampsDate!.year.toString().padLeft(4, '0')}-${stampsDate!.month.toString().padLeft(2, '0')}-${stampsDate!.day.toString().padLeft(2, '0')}",
        "stamps_time": stampsTime,
        "status": statusValues.reverse[status],
        "date_added": dateAdded!.toIso8601String(),
      };
}

enum IsCancelled { FALSE }

final isCancelledValues = EnumValues({"False": IsCancelled.FALSE});

enum StampsArriveDepart { ARRIVE, DEPART }

final stampsArriveDepartValues = EnumValues(
    {"Arrive": StampsArriveDepart.ARRIVE, "Depart": StampsArriveDepart.DEPART});

enum StampsCity { BRAISBAN, LAHORE, MILAN, ROME }

final stampsCityValues = EnumValues({
  "Braisban": StampsCity.BRAISBAN,
  "Lahore": StampsCity.LAHORE,
  "Milan": StampsCity.MILAN,
  "Rome": StampsCity.ROME
});

enum StampsCountry { AUSTRALIA, ITALY, PAKISTAN }

final stampsCountryValues = EnumValues({
  "Australia": StampsCountry.AUSTRALIA,
  "Italy": StampsCountry.ITALY,
  "Pakistan": StampsCountry.PAKISTAN
});

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

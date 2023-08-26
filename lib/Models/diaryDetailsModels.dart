// To parse this JSON data, do
//
//     final dirayDetailsModels = dirayDetailsModelsFromJson(jsonString);

import 'dart:convert';

DirayDetailsModels dirayDetailsModelsFromJson(String str) =>
    DirayDetailsModels.fromJson(json.decode(str));

String dirayDetailsModelsToJson(DirayDetailsModels data) =>
    json.encode(data.toJson());

class DirayDetailsModels {
  String? status;
  String? message;
  Data? data;

  DirayDetailsModels({
    this.status,
    this.message,
    this.data,
  });

  factory DirayDetailsModels.fromJson(Map<String, dynamic> json) =>
      DirayDetailsModels(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  String? travelDiaryId;
  String? travelLtineraryId;
  dynamic travelDiaryDayNo;
  DateTime? travelDiaryDate;
  String? travelDiaryEntry;
  dynamic travelDiaryShared;
  String? isCancalled;
  String? status;
  DateTime? dateAdded;
  List<TravelDiaryPicture>? travelDiaryPicture;

  Data({
    this.travelDiaryId,
    this.travelLtineraryId,
    this.travelDiaryDayNo,
    this.travelDiaryDate,
    this.travelDiaryEntry,
    this.travelDiaryShared,
    this.isCancalled,
    this.status,
    this.dateAdded,
    this.travelDiaryPicture,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        travelDiaryId: json["travel_diary_id"],
        travelLtineraryId: json["travel_ltinerary_id"],
        travelDiaryDayNo: json["travel_diary_day_no"],
        travelDiaryDate: DateTime.parse(json["travel_diary_date"]),
        travelDiaryEntry: json["travel_diary_entry"],
        travelDiaryShared: json["travel_diary_shared"],
        isCancalled: json["is_cancalled"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
        travelDiaryPicture: List<TravelDiaryPicture>.from(
            json["travel_diary_picture"]
                .map((x) => TravelDiaryPicture.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "travel_diary_id": travelDiaryId,
        "travel_ltinerary_id": travelLtineraryId,
        "travel_diary_day_no": travelDiaryDayNo,
        "travel_diary_date":
            "${travelDiaryDate!.year.toString().padLeft(4, '0')}-${travelDiaryDate!.month.toString().padLeft(2, '0')}-${travelDiaryDate!.day.toString().padLeft(2, '0')}",
        "travel_diary_entry": travelDiaryEntry,
        "travel_diary_shared": travelDiaryShared,
        "is_cancalled": isCancalled,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
        "travel_diary_picture":
            List<dynamic>.from(travelDiaryPicture!.map((x) => x.toJson())),
      };
}

class TravelDiaryPicture {
  String? travelDiaryPictureId;
  String? travelDiaryId;
  dynamic travelDiaryPictureOrder;
  String? tavelDiaryPictureImage;
  String? isCancelled;
  String? status;
  DateTime? dateAdded;

  TravelDiaryPicture({
    this.travelDiaryPictureId,
    this.travelDiaryId,
    this.travelDiaryPictureOrder,
    this.tavelDiaryPictureImage,
    this.isCancelled,
    this.status,
    this.dateAdded,
  });

  factory TravelDiaryPicture.fromJson(Map<String, dynamic> json) =>
      TravelDiaryPicture(
        travelDiaryPictureId: json["travel_diary_picture_id"],
        travelDiaryId: json["travel_diary_id"],
        travelDiaryPictureOrder: json["travel_diary_picture_order"],
        tavelDiaryPictureImage: json["tavel_diary_picture_image"],
        isCancelled: json["is_cancelled"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "travel_diary_picture_id": travelDiaryPictureId,
        "travel_diary_id": travelDiaryId,
        "travel_diary_picture_order": travelDiaryPictureOrder,
        "tavel_diary_picture_image": tavelDiaryPictureImage,
        "is_cancelled": isCancelled,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
      };
}

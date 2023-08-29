// To parse this JSON data, do
//
//     final getActivitylDetailsModels = getActivitylDetailsModelsFromJson(jsonString);

import 'dart:convert';

GetActivitylDetailsModels getActivitylDetailsModelsFromJson(String str) =>
    GetActivitylDetailsModels.fromJson(json.decode(str));

String getActivitylDetailsModelsToJson(GetActivitylDetailsModels data) =>
    json.encode(data.toJson());

class GetActivitylDetailsModels {
  String? status;
  List<Datum>? data;

  GetActivitylDetailsModels({
    this.status,
    this.data,
  });

  factory GetActivitylDetailsModels.fromJson(Map<String, dynamic> json) =>
      GetActivitylDetailsModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? travelLtineraryActivitiesId;
  String? travelLtineraryId;
  String? passportHolderId;
  String? dayNumber;
  DateTime? activityDate;
  String? activity;
  String? comments;
  String? breakfast;
  String? lunch;
  String? dinner;
  String? isCancelled;
  String? status;
  DateTime? dateAdded;

  Datum({
    this.travelLtineraryActivitiesId,
    this.travelLtineraryId,
    this.passportHolderId,
    this.dayNumber,
    this.activityDate,
    this.activity,
    this.comments,
    this.breakfast,
    this.lunch,
    this.dinner,
    this.isCancelled,
    this.status,
    this.dateAdded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        travelLtineraryActivitiesId: json["travel_ltinerary_activities_id"],
        travelLtineraryId: json["travel_ltinerary_id"],
        passportHolderId: json["passport_holder_id"],
        dayNumber: json["day_number"],
        activityDate: DateTime.parse(json["activity_date"]),
        activity: json["activity"],
        comments: json["comments"],
        breakfast: json["breakfast"],
        lunch: json["lunch"],
        dinner: json["dinner"],
        isCancelled: json["is_cancelled"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "travel_ltinerary_activities_id": travelLtineraryActivitiesId,
        "travel_ltinerary_id": travelLtineraryId,
        "passport_holder_id": passportHolderId,
        "day_number": dayNumber,
        "activity_date":
            "${activityDate!.year.toString().padLeft(4, '0')}-${activityDate!.month.toString().padLeft(2, '0')}-${activityDate!.day.toString().padLeft(2, '0')}",
        "activity": activity,
        "comments": comments,
        "breakfast": breakfast,
        "lunch": lunch,
        "dinner": dinner,
        "is_cancelled": isCancelled,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
      };
}

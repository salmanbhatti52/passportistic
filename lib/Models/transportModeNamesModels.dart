// To parse this JSON data, do
//
//     final transportModeNamesModels = transportModeNamesModelsFromJson(jsonString);

import 'dart:convert';

TransportModeNamesModels transportModeNamesModelsFromJson(String str) =>
    TransportModeNamesModels.fromJson(json.decode(str));

String transportModeNamesModelsToJson(TransportModeNamesModels data) =>
    json.encode(data.toJson());

class TransportModeNamesModels {
  String? status;
  Data? data;

  TransportModeNamesModels({
    this.status,
    this.data,
  });

  factory TransportModeNamesModels.fromJson(Map<String, dynamic> json) =>
      TransportModeNamesModels(
        status: json["status"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  String? transportModeId;
  String? modeName;
  String? modeImage;
  String? isCancelled;
  DateTime? dateAdded;
  String? actions;

  Data({
    this.transportModeId,
    this.modeName,
    this.modeImage,
    this.isCancelled,
    this.dateAdded,
    this.actions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transportModeId: json["transport_mode_id"],
        modeName: json["mode_name"],
        modeImage: json["mode_image"],
        isCancelled: json["is_cancelled"],
        dateAdded: DateTime.parse(json["date_added"]),
        actions: json["actions"],
      );

  Map<String, dynamic> toJson() => {
        "transport_mode_id": transportModeId,
        "mode_name": modeName,
        "mode_image": modeImage,
        "is_cancelled": isCancelled,
        "date_added": dateAdded!.toIso8601String(),
        "actions": actions,
      };
}

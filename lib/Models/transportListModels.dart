// To parse this JSON data, do
//
//     final transportListModels = transportListModelsFromJson(jsonString);

import 'dart:convert';

TransportListModels transportListModelsFromJson(String str) =>
    TransportListModels.fromJson(json.decode(str));

String transportListModelsToJson(TransportListModels data) =>
    json.encode(data.toJson());

class TransportListModels {
  String? status;
  List<Datum>? data;

  TransportListModels({
    this.status,
    this.data,
  });

  factory TransportListModels.fromJson(Map<String, dynamic> json) =>
      TransportListModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? transportModeId;
  String? modeName;
  String? modeImage;
  String? isCancelled;
  DateTime? dateAdded;
  String? actions;

  Datum({
    this.transportModeId,
    this.modeName,
    this.modeImage,
    this.isCancelled,
    this.dateAdded,
    this.actions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

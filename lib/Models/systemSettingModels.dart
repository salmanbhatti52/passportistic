// To parse this JSON data, do
//
//     final systemSettingsModels = systemSettingsModelsFromJson(jsonString);

import 'dart:convert';

SystemSettingsModels systemSettingsModelsFromJson(String str) => SystemSettingsModels.fromJson(json.decode(str));

String systemSettingsModelsToJson(SystemSettingsModels data) => json.encode(data.toJson());

class SystemSettingsModels {
    String? status;
    List<Datum>? data;

    SystemSettingsModels({
        this.status,
        this.data,
    });

    factory SystemSettingsModels.fromJson(Map<String, dynamic> json) => SystemSettingsModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? systemSettingsId;
    String? type;
    String? description;

    Datum({
        this.systemSettingsId,
        this.type,
        this.description,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        systemSettingsId: json["system_settings_id"],
        type: json["type"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "system_settings_id": systemSettingsId,
        "type": type,
        "description": description,
    };
}

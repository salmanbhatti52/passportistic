// To parse this JSON data, do
//
//     final getColorListModels = getColorListModelsFromJson(jsonString);

import 'dart:convert';

GetColorListModels getColorListModelsFromJson(String str) => GetColorListModels.fromJson(json.decode(str));

String getColorListModelsToJson(GetColorListModels data) => json.encode(data.toJson());

class GetColorListModels {
    String? status;
    List<Datum>? data;

    GetColorListModels({
        this.status,
        this.data,
    });

    factory GetColorListModels.fromJson(Map<String, dynamic> json) => GetColorListModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? stampsColorId;
    String? stampsColor;
    String? stampsColorRgb;
    String? stampsColorImage;
    String?isCancelled;
    String? status;
    DateTime? dateAdded;

    Datum({
        this.stampsColorId,
        this.stampsColor,
        this.stampsColorRgb,
        this.stampsColorImage,
        this.isCancelled,
        this.status,
        this.dateAdded,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        stampsColorId: json["stamps_color_id"],
        stampsColor: json["stamps_color"],
        stampsColorRgb: json["stamps_color_rgb"],
        stampsColorImage: json["stamps_color_image"],
        isCancelled: json["is_cancelled"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "stamps_color_id": stampsColorId,
        "stamps_color": stampsColor,
        "stamps_color_rgb": stampsColorRgb,
        "stamps_color_image": stampsColorImage,
        "is_cancelled": isCancelled,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
    };
}

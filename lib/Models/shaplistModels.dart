// To parse this JSON data, do
//
//     final shapeListModels = shapeListModelsFromJson(jsonString);

import 'dart:convert';

ShapeListModels shapeListModelsFromJson(String str) => ShapeListModels.fromJson(json.decode(str));

String shapeListModelsToJson(ShapeListModels data) => json.encode(data.toJson());

class ShapeListModels {
    String? status;
    List<Datum>? data;

    ShapeListModels({
        this.status,
        this.data,
    });

    factory ShapeListModels.fromJson(Map<String, dynamic> json) => ShapeListModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? shapesId;
    String? shapeName;
    String? shapeImage;
    DateTime? dateAdded;
    String? status;

    Datum({
        this.shapesId,
        this.shapeName,
        this.shapeImage,
        this.dateAdded,
        this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        shapesId: json["shapes_id"],
        shapeName: json["shape_name"],
        shapeImage: json["shape_image"],
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "shapes_id": shapesId,
        "shape_name": shapeName,
        "shape_image": shapeImage,
        "date_added": dateAdded!.toIso8601String(),
        "status": status,
    };
}

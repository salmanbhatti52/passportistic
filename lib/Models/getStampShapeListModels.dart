// To parse this JSON data, do
//
//     final getStampShapeListModels = getStampShapeListModelsFromJson(jsonString);

import 'dart:convert';

GetStampShapeListModels getStampShapeListModelsFromJson(String str) => GetStampShapeListModels.fromJson(json.decode(str));

String getStampShapeListModelsToJson(GetStampShapeListModels data) => json.encode(data.toJson());

class GetStampShapeListModels {
    String? status;
    List<Datum>? data;

    GetStampShapeListModels({
        this.status,
        this.data,
    });

    factory GetStampShapeListModels.fromJson(Map<String, dynamic> json) => GetStampShapeListModels(
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
    String? width;
    String? height;
    DateTime? dateAdded;
    Status? status;

    Datum({
        this.shapesId,
        this.shapeName,
        this.shapeImage,
        this.width,
        this.height,
        this.dateAdded,
        this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        shapesId: json["shapes_id"],
        shapeName: json["shape_name"],
        shapeImage: json["shape_image"],
        width: json["width"],
        height: json["height"],
        dateAdded: DateTime.parse(json["date_added"]),
        status: statusValues.map[json["status"]],
    );

    Map<String, dynamic> toJson() => {
        "shapes_id": shapesId,
        "shape_name": shapeName,
        "shape_image": shapeImage,
        "width": width,
        "height": height,
        "date_added": dateAdded!.toIso8601String(),
        "status": statusValues.reverse[status],
    };
}

enum Status {
    ACTIVE
}

final statusValues = EnumValues({
    "Active": Status.ACTIVE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

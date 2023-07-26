// To parse this JSON data, do
//
//     final coverDesignDataModel = coverDesignDataModelFromJson(jsonString);

import 'dart:convert';

CoverDesignDataModel coverDesignDataModelFromJson(String str) => CoverDesignDataModel.fromJson(json.decode(str));

String coverDesignDataModelToJson(CoverDesignDataModel data) => json.encode(data.toJson());

class CoverDesignDataModel {
    String? status;
    List<Datum>? data;

    CoverDesignDataModel({
        this.status,
        this.data,
    });

    factory CoverDesignDataModel.fromJson(Map<String, dynamic> json) => CoverDesignDataModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? coverImagesId;
    String? name;
    String? image;
    String? status;
    DateTime? dateAdded;

    Datum({
        this.coverImagesId,
        this.name,
        this.image,
        this.status,
        this.dateAdded,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        coverImagesId: json["cover_images_id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "cover_images_id": coverImagesId,
        "name": name,
        "image": image,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
    };
}

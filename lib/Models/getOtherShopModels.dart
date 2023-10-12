// To parse this JSON data, do
//
//     final getOtherShopModels = getOtherShopModelsFromJson(jsonString);

import 'dart:convert';

GetOtherShopModels getOtherShopModelsFromJson(String str) => GetOtherShopModels.fromJson(json.decode(str));

String getOtherShopModelsToJson(GetOtherShopModels data) => json.encode(data.toJson());

class GetOtherShopModels {
    String? status;
    List<Datum>? data;

    GetOtherShopModels({
        this.status,
        this.data,
    });

    factory GetOtherShopModels.fromJson(Map<String, dynamic> json) => GetOtherShopModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? managePackagesId;
    String? packageName;
    String? packagePrice;
    String? packageImage;
    String? status;
    DateTime? dateAdded;

    Datum({
        this.managePackagesId,
        this.packageName,
        this.packagePrice,
        this.packageImage,
        this.status,
        this.dateAdded,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        managePackagesId: json["manage_packages_id"],
        packageName: json["package_name"],
        packagePrice: json["package_price"],
        packageImage: json["package_image"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "manage_packages_id": managePackagesId,
        "package_name": packageName,
        "package_price": packagePrice,
        "package_image": packageImage,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
    };
}

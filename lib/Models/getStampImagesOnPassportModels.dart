// To parse this JSON data, do
//
//     final getStampImagesOnPassportModels = getStampImagesOnPassportModelsFromJson(jsonString);

import 'dart:convert';

GetStampImagesOnPassportModels getStampImagesOnPassportModelsFromJson(String str) => GetStampImagesOnPassportModels.fromJson(json.decode(str));

String getStampImagesOnPassportModelsToJson(GetStampImagesOnPassportModels data) => json.encode(data.toJson());

class GetStampImagesOnPassportModels {
    String? status;
    List<Datum>? data;

    GetStampImagesOnPassportModels({
        this.status,
        this.data,
    });

    factory GetStampImagesOnPassportModels.fromJson(Map<String, dynamic> json) => GetStampImagesOnPassportModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? stampsId;
    String? passportHolderId;
    String? stampsArriveDepart;
    String? transportModeId;
    String? stampShapeId;
    String? stampsColorId;
    String? stampImage;
    String?stampsOffsetRotation;
    String? stampsOffsetHorizental;
    String? stampsOffsetVertical;
    String? stampsPageNumber;
    String? stampsPositionNumber;
    String? stampsCountry;
    String? stampsCity;
    String? isCancelled;
    DateTime? stampsDate;
    String? stampsTime;
    String? status;
    DateTime? dateAdded;

    Datum({
        this.stampsId,
        this.passportHolderId,
        this.stampsArriveDepart,
        this.transportModeId,
        this.stampShapeId,
        this.stampsColorId,
        this.stampImage,
        this.stampsOffsetRotation,
        this.stampsOffsetHorizental,
        this.stampsOffsetVertical,
        this.stampsPageNumber,
        this.stampsPositionNumber,
        this.stampsCountry,
        this.stampsCity,
        this.isCancelled,
        this.stampsDate,
        this.stampsTime,
        this.status,
        this.dateAdded,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        stampsId: json["stamps_id"],
        passportHolderId: json["passport_holder_id"],
        stampsArriveDepart: json["stamps_arrive_depart"],
        transportModeId: json["transport_mode_id"],
        stampShapeId: json["stamp_shape_id"],
        stampsColorId: json["stamps_color_id"],
        stampImage: json["stamp_image"],
        stampsOffsetRotation: json["stamps_offset_rotation"],
        stampsOffsetHorizental: json["stamps_offset_horizental"],
        stampsOffsetVertical: json["stamps_offset_vertical"],
        stampsPageNumber: json["stamps_page_number"],
        stampsPositionNumber: json["stamps_position_number"],
        stampsCountry: json["stamps_country"],
        stampsCity: json["stamps_city"],
        isCancelled: json["is_cancelled"],
        stampsDate: DateTime.parse(json["stamps_date"]),
        stampsTime: json["stamps_time"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "stamps_id": stampsId,
        "passport_holder_id": passportHolderId,
        "stamps_arrive_depart": stampsArriveDepart,
        "transport_mode_id": transportModeId,
        "stamp_shape_id": stampShapeId,
        "stamps_color_id": stampsColorId,
        "stamp_image": stampImage,
        "stamps_offset_rotation": stampsOffsetRotation,
        "stamps_offset_horizental": stampsOffsetHorizental,
        "stamps_offset_vertical": stampsOffsetVertical,
        "stamps_page_number": stampsPageNumber,
        "stamps_position_number": stampsPositionNumber,
        "stamps_country": stampsCountry,
        "stamps_city": stampsCity,
        "is_cancelled": isCancelled,
        "stamps_date": "${stampsDate!.year.toString().padLeft(4, '0')}-${stampsDate!.month.toString().padLeft(2, '0')}-${stampsDate!.day.toString().padLeft(2, '0')}",
        "stamps_time": stampsTime,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
    };
}

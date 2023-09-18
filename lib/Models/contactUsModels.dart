// To parse this JSON data, do
//
//     final contactUsModels = contactUsModelsFromJson(jsonString);

import 'dart:convert';

ContactUsModels contactUsModelsFromJson(String str) => ContactUsModels.fromJson(json.decode(str));

String contactUsModelsToJson(ContactUsModels data) => json.encode(data.toJson());

class ContactUsModels {
    String? status;
    List<Datum>? data;

    ContactUsModels({
        this.status,
        this.data,
    });

    factory ContactUsModels.fromJson(Map<String, dynamic> json) => ContactUsModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? contactUsId;
    String? passportHolderId;
    String? firstName;
    String? email;
    String? comments;
    String? status;
    DateTime? dateAdded;

    Datum({
        this.contactUsId,
        this.passportHolderId,
        this.firstName,
        this.email,
        this.comments,
        this.status,
        this.dateAdded,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        contactUsId: json["contact_us_id"],
        passportHolderId: json["passport_holder_id"],
        firstName: json["first_name"],
        email: json["email"],
        comments: json["comments"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "contact_us_id": contactUsId,
        "passport_holder_id": passportHolderId,
        "first_name": firstName,
        "email": email,
        "comments": comments,
        "status": status,
        "date_added": dateAdded!.toIso8601String(),
    };
}

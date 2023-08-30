// To parse this JSON data, do
//
//     final resetPasswordModel = resetPasswordModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordModel resetPasswordModelFromJson(String str) =>
    ResetPasswordModel.fromJson(json.decode(str));

String resetPasswordModelToJson(ResetPasswordModel data) =>
    json.encode(data.toJson());

class ResetPasswordModel {
  String? status;
  String? message;
  Data? data;

  ResetPasswordModel({
    this.status,
    this.message,
    this.data,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  String? passportHolderId;
  dynamic oneSignalId;
  dynamic passportDesignId;
  dynamic fullName;
  dynamic username;
  String? email;
  String? password;
  String? accountType;
  dynamic profilePicture;
  dynamic socialAccType;
  dynamic googleAccessToken;
  dynamic facebookId;
  DateTime? dateAdded;
  String? status;
  String? verifyCode;
  String? notifications;
  String? beSeen;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic phoneNumber;
  dynamic genderId;
  dynamic nationality;
  dynamic dob;
  dynamic numberOfPages;
  dynamic currencyId;
  dynamic passportStampsHeld;
  String? isCancelled;

  Data({
    this.passportHolderId,
    this.oneSignalId,
    this.passportDesignId,
    this.fullName,
    this.username,
    this.email,
    this.password,
    this.accountType,
    this.profilePicture,
    this.socialAccType,
    this.googleAccessToken,
    this.facebookId,
    this.dateAdded,
    this.status,
    this.verifyCode,
    this.notifications,
    this.beSeen,
    this.firstName,
    this.middleName,
    this.lastName,
    this.phoneNumber,
    this.genderId,
    this.nationality,
    this.dob,
    this.numberOfPages,
    this.currencyId,
    this.passportStampsHeld,
    this.isCancelled,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        passportHolderId: json["passport_holder_id"],
        oneSignalId: json["one_signal_id"],
        passportDesignId: json["passport_design_id"],
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        accountType: json["account_type"],
        profilePicture: json["profile_picture"],
        socialAccType: json["social_acc_type"],
        googleAccessToken: json["google_access_token"],
        facebookId: json["facebook_id"],
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
        verifyCode: json["verify_code"],
        notifications: json["notifications"],
        beSeen: json["be_seen"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        genderId: json["gender_id"],
        nationality: json["nationality"],
        dob: json["dob"],
        numberOfPages: json["number_of_pages"],
        currencyId: json["currency_id"],
        passportStampsHeld: json["passport_stamps_held"],
        isCancelled: json["is_cancelled"],
      );

  Map<String, dynamic> toJson() => {
        "passport_holder_id": passportHolderId,
        "one_signal_id": oneSignalId,
        "passport_design_id": passportDesignId,
        "full_name": fullName,
        "username": username,
        "email": email,
        "password": password,
        "account_type": accountType,
        "profile_picture": profilePicture,
        "social_acc_type": socialAccType,
        "google_access_token": googleAccessToken,
        "facebook_id": facebookId,
        "date_added": dateAdded!.toIso8601String(),
        "status": status,
        "verify_code": verifyCode,
        "notifications": notifications,
        "be_seen": beSeen,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "gender_id": genderId,
        "nationality": nationality,
        "dob": dob,
        "number_of_pages": numberOfPages,
        "currency_id": currencyId,
        "passport_stamps_held": passportStampsHeld,
        "is_cancelled": isCancelled,
      };
}

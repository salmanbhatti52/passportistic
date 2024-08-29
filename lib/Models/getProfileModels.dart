// To parse this JSON data, do
//
//     final getProfileModels = getProfileModelsFromJson(jsonString);

import 'dart:convert';

GetProfileModels getProfileModelsFromJson(String str) =>
    GetProfileModels.fromJson(json.decode(str));

String getProfileModelsToJson(GetProfileModels data) =>
    json.encode(data.toJson());

class GetProfileModels {
  String? status;
  Data? data;

  GetProfileModels({
    this.status,
    this.data,
  });

  factory GetProfileModels.fromJson(Map<String, dynamic> json) =>
      GetProfileModels(
        status: json["status"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  String? passportHolderId;
  dynamic oneSignalId;
  String? passportDesignId;
  String? fullName;
  String? username;
  String? email;
  String? password;
  String? accountType;
  String? profilePicture;
  dynamic socialAccType;
  dynamic googleAccessToken;
  dynamic facebookId;
  String? dateAdded;
  String? status;
  String? verifyCode;
  dynamic passportNumber;
  String? notifications;
  String? beSeen;
  String? firstName;
  String? middleName;
  String? lastName;
  String? phoneNumber;
  String? genderId;
  String? nationality;
  String? dob;
  String? numberOfPages;
  dynamic currencyId;
  String? passportStampsHeld;
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
    this.passportNumber,
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
        dateAdded: json["date_added"],
        status: json["status"],
        verifyCode: json["verify_code"],
        passportNumber: json["passport_number"],
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
        "date_added": dateAdded,
        "status": status,
        "verify_code": verifyCode,
        "passport_number": passportNumber,
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

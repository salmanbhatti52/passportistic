// To parse this JSON data, do
//
//     final signUpDetailsModel = signUpDetailsModelFromJson(jsonString);

import 'dart:convert';

SignUpDetailsModel signUpDetailsModelFromJson(String str) =>
    SignUpDetailsModel.fromJson(json.decode(str));

String signUpDetailsModelToJson(SignUpDetailsModel data) =>
    json.encode(data.toJson());

class SignUpDetailsModel {
  String? status;
  Data? data;

  SignUpDetailsModel({
    this.status,
    this.data,
  });

  factory SignUpDetailsModel.fromJson(Map<String, dynamic> json) =>
      SignUpDetailsModel(
        status: json["status"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  String? usersCustomersId;
  String? oneSignalId;
  String? fullName;
  String? username;
  String? email;
  String? password;
  String? accountType;
  String? profilePicture;
  String? socialAccType;
  String? googleAccessToken;
  dynamic facebookId;
  dynamic dateAdded;
  String? status;
  String? verifyCode;
  String? notifications;
  String? beSeen;
  String? firstName;
  String? middleName;
  String? lastName;
  dynamic phoneNumber;
  String? gender;
  String? nationality;
  DateTime? dob;
  String? numberOfPages;
  String? currency;

  Data({
    this.usersCustomersId,
    this.oneSignalId,
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
    this.gender,
    this.nationality,
    this.dob,
    this.numberOfPages,
    this.currency,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        usersCustomersId: json["users_customers_id"],
        oneSignalId: json["one_signal_id"],
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
        notifications: json["notifications"],
        beSeen: json["be_seen"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        nationality: json["nationality"],
        dob: DateTime.parse(json["dob"]),
        numberOfPages: json["number_of_pages"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "users_customers_id": usersCustomersId,
        "one_signal_id": oneSignalId,
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
        "notifications": notifications,
        "be_seen": beSeen,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "gender": gender,
        "nationality": nationality,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "number_of_pages": numberOfPages,
        "currency": currency,
      };
}

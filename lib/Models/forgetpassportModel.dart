// To parse this JSON data, do
//
//     final forgetPasswordModel = forgetPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgetPasswordModel forgetPasswordModelFromJson(String str) =>
    ForgetPasswordModel.fromJson(json.decode(str));

String forgetPasswordModelToJson(ForgetPasswordModel data) =>
    json.encode(data.toJson());

class ForgetPasswordModel {
  String? status;
  Data? data;

  ForgetPasswordModel({
    this.status,
    this.data,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordModel(
        status: json["status"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  int? otp;
  String? message;

  Data({
    this.otp,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otp: json["otp"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "message": message,
      };
}

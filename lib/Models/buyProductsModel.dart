// To parse this JSON data, do
//
//     final buyProductsModel = buyProductsModelFromJson(jsonString);

import 'dart:convert';

BuyProductsModel buyProductsModelFromJson(String str) =>
    BuyProductsModel.fromJson(json.decode(str));

String buyProductsModelToJson(BuyProductsModel data) =>
    json.encode(data.toJson());

class BuyProductsModel {
  String? status;
  Data? data;

  BuyProductsModel({
    this.status,
    this.data,
  });

  factory BuyProductsModel.fromJson(Map<String, dynamic> json) =>
      BuyProductsModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  String? purchaseDetailsId;
  String? passportHolderId;
  String? transactionId;
  String? productId;
  String? productType;
  String? amount;
  DateTime? dateAdded;
  String? status;

  Data({
    this.purchaseDetailsId,
    this.passportHolderId,
    this.transactionId,
    this.productId,
    this.productType,
    this.amount,
    this.dateAdded,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        purchaseDetailsId: json["purchase_details_id"],
        passportHolderId: json["passport_holder_id"],
        transactionId: json["transaction_id"],
        productId: json["product_id"],
        productType: json["product_type"],
        amount: json["amount"],
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "purchase_details_id": purchaseDetailsId,
        "passport_holder_id": passportHolderId,
        "transaction_id": transactionId,
        "product_id": productId,
        "product_type": productType,
        "amount": amount,
        "date_added": dateAdded!.toIso8601String(),
        "status": status,
      };
}

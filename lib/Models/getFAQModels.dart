// To parse this JSON data, do
//
//     final faqModels = faqModelsFromJson(jsonString);

import 'dart:convert';

FaqModels faqModelsFromJson(String str) => FaqModels.fromJson(json.decode(str));

String faqModelsToJson(FaqModels data) => json.encode(data.toJson());

class FaqModels {
    String? status;
    List<Datum>? data;

    FaqModels({
        this.status,
        this.data,
    });

    factory FaqModels.fromJson(Map<String, dynamic> json) => FaqModels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? faqsId;
    String? faqQuestion;
    String? faqAnswer;
    DateTime? dateAdded;
    String? status;

    Datum({
        this.faqsId,
        this.faqQuestion,
        this.faqAnswer,
        this.dateAdded,
        this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        faqsId: json["faqs_id"],
        faqQuestion: json["faq_question"],
        faqAnswer: json["faq_answer"],
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "faqs_id": faqsId,
        "faq_question": faqQuestion,
        "faq_answer": faqAnswer,
        "date_added": dateAdded!.toIso8601String(),
        "status": status,
    };
}

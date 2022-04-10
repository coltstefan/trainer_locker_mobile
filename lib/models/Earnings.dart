// To parse this JSON data, do
//
//     final earnings = earningsFromJson(jsonString);

import 'dart:convert';

Earnings earningsFromJson(String str) => Earnings.fromJson(json.decode(str));

String earningsToJson(Earnings data) => json.encode(data.toJson());

class Earnings {
    Earnings({
        this.id,
        this.trainerId,
    });

    String id;
    String trainerId;

    factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
        id: json["_id"],
        trainerId: json["trainerId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "trainerId": trainerId,
    };
}

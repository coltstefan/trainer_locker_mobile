// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
    Payment({
        this.id,
        this.earningsId,
        this.total,
    });

    String id;
    String earningsId;
    int total;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["_id"],
        earningsId: json["earningsId"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "earningsId": earningsId,
        "total": total,
    };
}

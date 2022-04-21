// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
    Payment({
        this.id,
        this.userId,
        this.trainerId,
        this.trainingPlanId,
        this.payment,
        this.yearCreated,
        this.monthCreated,
        this.dayCreated,
    });

    String id;
    String userId;
    String trainerId;
    String trainingPlanId;
    double payment;
    int yearCreated;
    String monthCreated;
    int dayCreated;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        userId: json["userId"],
        trainerId: json["trainerId"],
        trainingPlanId: json["trainingPlanId"],
        payment: json["payment"],
        yearCreated: json["yearCreated"],
        monthCreated: json["monthCreated"],
        dayCreated: json["dayCreated"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "trainerId": trainerId,
        "trainingPlanId": trainingPlanId,
        "payment": payment,
        "yearCreated": yearCreated,
        "monthCreated": monthCreated,
        "dayCreated": dayCreated,
    };
}

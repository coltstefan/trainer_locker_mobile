// To parse this JSON data, do
//
//     final statistics = statisticsFromJson(jsonString);

import 'dart:convert';

Statistics statisticsFromJson(String str) => Statistics.fromJson(json.decode(str));

String statisticsToJson(Statistics data) => json.encode(data.toJson());

class Statistics {
    Statistics({
        this.id,
        this.trainingPlanId,
        this.views,
        this.orders,
    });

    String id;
    String trainingPlanId;
    int views;
    int orders;

    factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        id: json["_id"],
        trainingPlanId: json["trainingPlanId"],
        views: json["views"],
        orders: json["orders"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "trainingPlanId": trainingPlanId,
        "views": views,
        "orders": orders,
    };
}

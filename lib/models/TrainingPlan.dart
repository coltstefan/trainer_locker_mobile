// To parse this JSON data, do
//
//     final trainingPlan = trainingPlanFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_final/models/TrainingDay.dart';

TrainingPlan trainingPlanFromJson(String str) => TrainingPlan.fromJson(json.decode(str));

String trainingPlanToJson(TrainingPlan data) => json.encode(data.toJson());

class TrainingPlan {
    TrainingPlan({
        this.id,
        this.name,
        this.duration,
        this.price,
        this.commentIds,
        this.userIds,
        this.trainingDays,
        this.trainerId,
    });

    String id;
    String name;
    int duration;
    double price;
    List<dynamic> commentIds = [];
    List<dynamic> userIds = [];
    List<dynamic> trainingDays;
    List<TrainingDay> trainingDaysList = [];
    String trainerId;

    factory TrainingPlan.fromJson(Map<String, dynamic> json) => TrainingPlan(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
        commentIds: List<dynamic>.from(json["commentIds"].map((x) => x)),
        userIds: List<dynamic>.from(json["userIds"].map((x) => x)),
        trainingDays: List<dynamic>.from(json["trainingDays"].map((x) => x)),
        trainerId: json["trainerId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "price": price,
        "commentIds": List<dynamic>.from(commentIds.map((x) => x)),
        "userIds": List<dynamic>.from(userIds.map((x) => x)),
        "trainingDays": List<dynamic>.from(trainingDays.map((x) => x)),
        "trainerId": trainerId,
    };
}

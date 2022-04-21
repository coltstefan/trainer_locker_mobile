// To parse this JSON data, do
//
//     final progressiveOverload = progressiveOverloadFromJson(jsonString);

import 'dart:convert';

ProgressiveOverloadModel progressiveOverloadFromJson(String str) => ProgressiveOverloadModel.fromJson(json.decode(str));

String progressiveOverloadToJson(ProgressiveOverloadModel data) => json.encode(data.toJson());

class ProgressiveOverloadModel {
    ProgressiveOverloadModel({
        this.id,
        this.userId,
        this.exerciseId,
        this.weight,
        this.reps,
        this.sets,
    });

    String id;
    String userId;
    String exerciseId;
    int weight;
    int reps;
    int sets;

    factory ProgressiveOverloadModel.fromJson(Map<String, dynamic> json) => ProgressiveOverloadModel(
        id: json["id"],
        userId: json["userId"],
        exerciseId: json["exerciseId"],
        weight: json["weight"],
        reps: json["reps"],
        sets: json["sets"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "exerciseId": exerciseId,
        "weight": weight,
        "reps": reps,
        "sets": sets,
    };
}

// To parse this JSON data, do
//
//     final trainingDay = trainingDayFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_final/models/ExerciseSet.dart';

TrainingDay trainingDayFromJson(String str) => TrainingDay.fromJson(json.decode(str));

String trainingDayToJson(TrainingDay data) => json.encode(data.toJson());

class TrainingDay {
    TrainingDay({
        this.id,
        this.name,
        this.exerciseSetIds,
    });

    String id;
    String name;
    List<dynamic> exerciseSetIds;
    List<ExerciseSet> exerciseSets = [];

    factory TrainingDay.fromJson(Map<String, dynamic> json) => TrainingDay(
        id: json["id"],
        name: json["name"],
        exerciseSetIds: List<dynamic>.from(json["exerciseSetIds"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "exerciseSetIds": List<dynamic>.from(exerciseSetIds.map((x) => x)),
    };
}
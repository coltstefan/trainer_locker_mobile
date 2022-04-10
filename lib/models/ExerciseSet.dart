// To parse this JSON data, do
//
//     final exerciseSet = exerciseSetFromJson(jsonString);

import 'dart:convert';

import 'Exercise.dart';

ExerciseSet exerciseSetFromJson(String str) => ExerciseSet.fromJson(json.decode(str));

String exerciseSetToJson(ExerciseSet data) => json.encode(data.toJson());

class ExerciseSet {
    ExerciseSet({
        this.id,
        this.exerciseId,
        this.sets,
        this.reps,
    });

    String id;
    String exerciseId;
    int sets;
    int reps;
    Exercise exercise = Exercise();

    factory ExerciseSet.fromJson(Map<String, dynamic> json) => ExerciseSet(
        id: json["_id"],
        exerciseId: json["exerciseId"],
        sets: json["sets"],
        reps: json["reps"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "exerciseId": exerciseId,
        "sets": sets,
        "reps": reps,
    };
}

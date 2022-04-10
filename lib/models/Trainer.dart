// To parse this JSON data, do
//
//     final trainer = trainerFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_final/models/TrainingPlan.dart';

Trainer trainerFromJson(String str) => Trainer.fromJson(json.decode(str));

String trainerToJson(Trainer data) => json.encode(data.toJson());

class Trainer {
    Trainer({
        this.id,
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.fitnessProgrammes,
    });

    String id;
    String username;
    String email;
    String firstName;
    String lastName;
    List<dynamic> fitnessProgrammes = [];
    List<TrainingPlan> trainingPlans = [];
    int totalOrders = 0;

    factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fitnessProgrammes: List<dynamic>.from(json["fitnessProgrammes"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "fitnessProgrammes": List<dynamic>.from(fitnessProgrammes.map((x) => x)),
    };
}

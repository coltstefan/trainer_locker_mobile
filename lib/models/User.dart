// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_final/models/TrainingPlan.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    Users({
        this.id,
        this.email,
        this.username,
        this.password,
        this.firstName,
        this.lastName,
        this.isTrainer,
        this.trainingPlanIds,
        this.trainer,
    });

    String id;
    String email;
    String username;
    String password;
    String firstName;
    String lastName;
    bool isTrainer;
    List<dynamic> trainingPlanIds = [];
    List<TrainingPlan> trainingPlansLOCAL = [];
    bool trainer;

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        isTrainer: json["isTrainer"],
        trainingPlanIds: List<dynamic>.from(json["trainingPlanIds"].map((x) => x)),
        trainer: json["trainer"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "isTrainer": isTrainer,
        "trainingPlanIds": List<dynamic>.from(trainingPlanIds.map((x) => x)),
        "trainer": trainer,
    };
}

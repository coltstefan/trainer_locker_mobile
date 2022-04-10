// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
    Comment({
        this.id,
        this.comment,
        this.trainingPlanId,
        this.userId,
        this.lastName,
        this.firstName,
        this.yearCreated,
        this.monthCreated,
        this.dayCreated,
    });

    String id;
    String comment;
    String trainingPlanId;
    String userId;
    String lastName;
    String firstName;
    int yearCreated;
    String monthCreated;
    int dayCreated;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        comment: json["comment"],
        trainingPlanId: json["trainingPlanId"],
        userId: json["userId"],
        lastName: json["lastName"],
        firstName: json["firstName"],
        yearCreated: json["yearCreated"],
        monthCreated: json["monthCreated"],
        dayCreated: json["dayCreated"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "trainingPlanId": trainingPlanId,
        "userId": userId,
        "lastName": lastName,
        "firstName": firstName,
        "yearCreated": yearCreated,
        "monthCreated": monthCreated,
        "dayCreated": dayCreated,
    };
}

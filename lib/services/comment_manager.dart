import 'dart:convert';

import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:mobile_final/models/Comment.dart';
import 'package:mobile_final/models/TrainingPlan.dart';
import 'package:mobile_final/services/training_plan_manager.dart';

class Comments_Manager {
  // Future<Comment> getCommentById(String id) async{

  //   var client = http.Client();

  //   String api = globals.API_ardress;

  //   try{

  //       var response = await client.get(Uri.parse("$api/api/v1/comment"))

  //   }catch(err){

  //   }

  // }

  Future<List<Comment>> getCommentsByTp(String trainingPlan) async {
    var client = http.Client();

    String api = globals.API_ardress;
    List<Comment> commentsReturn = [];

    try {
      print("GET COMMENTS BY TP EXECUTED");

      var response = await client.get(
          Uri.parse("$api/api/v1/comment/findByTrainingPlanId/$trainingPlan"));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var comments = jsonDecode(jsonString);

        for (var cm in comments) {
          Comment comment = Comment(
              id: cm['id'],
              comment: cm['comment'],
              trainingPlanId: cm['trainingPlanId'],
              userId: cm['userId'],
              lastName: cm['lastName'],
              firstName: cm['firstName'],
              yearCreated: cm['yearCreated'],
              monthCreated: cm['monthCreated'],
              dayCreated: cm['dayCreated']);

          commentsReturn.add(comment);
        }
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (err) {
      print("ERROR GET COMMENTS BY TP");
      print(err);
    }

    return commentsReturn;
  }

  Future<Comment> createComment(String text, String tp_id) async {
    var client = http.Client();

    try {
      String api = globals.API_ardress;
      String id = globals.currUser.id;
      print("1");
      var response = await http.post(Uri.parse("$api/api/v1/comment/create"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: jsonEncode({
            'comment': text,
            'trainingPlanId': tp_id,
            'userId': id,
            'firstName': globals.currUser.firstName,
            'lastName': globals.currUser.lastName
          }));

      if (response.statusCode == 200) {
              print("2");

        print("COMMEND ADDED");
        var jsonString = response.body;
        var cm = jsonDecode(jsonString);

        Comment comment = Comment(
            id: cm['id'],
            comment: cm['comment'],
            trainingPlanId: cm['trainingPlanId'],
            userId: cm['userId'],
            lastName: cm['lastName'],
            firstName: cm['firstName'],
            yearCreated: cm['yearCreated'],
            monthCreated: cm['monthCreated'],
            dayCreated: cm['dayCreated']);

        await TrainingPlan_Manager().getAllTrainingPlans();
        return comment;
      }
      else{
        print(response.statusCode);
        print(response.body);
      }
    } catch (err) {
      print(err);
    }
  }
}

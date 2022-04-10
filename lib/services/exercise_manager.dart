

import 'dart:convert';
import 'dart:math';

import 'package:mobile_final/models/TrainingDay.dart';
import 'package:mobile_final/models/TrainingPlan.dart';

import '../models/Exercise.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/helpers/globals.dart' as globals;

import '../models/ExerciseSet.dart';

class Exercise_Manager{


  String api = globals.API_ardress;

  Future<void> getAllExercises() async{
    var client = http.Client();
    List<Exercise> exerciseList = [];

    try{
        var response = await http.get(Uri.parse("$api/api/v1/exercise"));

        if(response.statusCode == 200){
          var jsonString = response.body;
          var exercises = json.decode(jsonString);

        for(var exerciseitem in exercises){
          Exercise exercise = Exercise(
              id: exerciseitem['id'],
              name: exerciseitem['name'],
              description: exerciseitem['description']
          );
          exerciseList.add(exercise);
        }
        }
        
        globals.exercises = exerciseList;
        // print("AICI EXERCISE");
        // print(globals.exercises.length);
        

    }catch(err){
        print(err);
        
    }

    //await Future.delayed(const Duration(seconds: 1));


  }

  String getExerciseName(String id){

    try{
    for(Exercise exercise in globals.exercises){
      if(exercise.id == id){
        return exercise.name;
      }
    }
    }catch(err){

    print(err.toString());
    return "None";

    }
  }

  Future<void> saveExerciseSets(List<ExerciseSet> exerciseSets, TrainingDay trainingDay) async{


      var client = http.Client();
      List<String> ids = [];

      for(ExerciseSet exerciseSet in globals.currExerciseSets){

         var response = await http.post(Uri.parse("$api/api/v1/exerciseSet/create"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
            //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: jsonEncode({
            'exerciseId': exerciseSet.exerciseId,
            'sets': exerciseSet.sets,
            'reps': exerciseSet.reps,
          }));

          if(response.statusCode == 200){
            var jsonString = response.body;
            var es = jsonDecode(jsonString);

            ids.add(es['id']);
            trainingDay.exerciseSetIds = ids;
          }
          else{
            print(response.body);
          }





      }
  }

  Future<void> saveTrainingDays(List<TrainingDay> trainingDays, TrainingPlan trainingPlan) async{

          var client = http.Client();
          List<String> ids = [];

          for(TrainingDay trainingDay in trainingDays){

          var response = await http.post(Uri.parse("$api/api/v1/trainingDay/create"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
            //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: jsonEncode({
            'name': trainingDay.name,
          }));

          if(response.statusCode == 200){
            var jsonString = response.body;
            var td = jsonDecode(jsonString);
            String id_td = td['id'];
            ids.add(id_td);

            for(String exerciseSetId in trainingDay.exerciseSetIds){
              
              var response2 = await http.put(Uri.parse("$api/api/v1/trainingDay/update/$id_td"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                "Access-Control-Allow-Origin": "*", // Required for CORS support to work
                //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
                "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
                "Access-Control-Allow-Methods": "PUT, OPTIONS"
              },
              body: jsonEncode({
                'exerciseSetId': exerciseSetId,
              }));

              if(response2.statusCode == 200){
                print("ExerciseSet Added");
              }
              else{
                print(response2.body);
              }

            }
          }
          else{
            print(response.body);
          }

          String id_tp = trainingPlan.id;
          var response3 = await http.put(Uri.parse("$api/api/v1/trainingPlan/addTrainingDay/$id_tp"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                "Access-Control-Allow-Origin": "*", // Required for CORS support to work
                //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
                "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
                "Access-Control-Allow-Methods": "PUT, OPTIONS"
              },
              body: jsonEncode({
                'trainingDayId': ids.last,
              }));

              if(response3.statusCode == 200){
                print("TrainingDay  Added");
              }
              else{
                print(response3.body);
              }




          }


      }

      Future<Exercise> getExerciseById(String id) async{

        var client = http.Client();

        try{
          String api = globals.API_ardress;

          var response = await client.get(Uri.parse("$api/api/v1/exercise/findById/$id"));

          if(response.statusCode == 200){
            
            var jsonString = response.body;
            var ex = jsonDecode(jsonString);

            Exercise exercise = Exercise(
              id: ex['id'],
              name: ex['name'],
              description: ex['description']
            );

            return exercise;


          }
          else{
            print(response.body);
          }

        }catch(err){
          print(err);
        }


      }


}
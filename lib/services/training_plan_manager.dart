

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/Exercise.dart';
import 'package:mobile_final/models/ExerciseSet.dart';
import 'package:mobile_final/models/Trainer.dart';
import 'package:mobile_final/models/TrainingDay.dart';
import 'package:mobile_final/services/api_manager.dart';
import 'package:mobile_final/services/exercise_manager.dart';
import 'package:mobile_final/services/trainer_manager.dart';

import '../models/TrainingPlan.dart';


class TrainingPlan_Manager{

  String api = globals.API_ardress;


  Future<void> createPlan(String name, int duration, double price,String trainerId) async{

      var client = http.Client();
      //print(trainerId);

      var response = await http.post(Uri.parse("$api/api/v1/trainingPlan/create"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
            //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: jsonEncode({
            'name': name,
            'duration': duration,
            'price': price,
            'trainerId': trainerId
          }));
      
      if(response.statusCode == 200){
        //print(response.body);
        var jsonString = response.body;
        var tp = json.decode(jsonString);
        globals.currentTrainingPlan.id = tp['id'];
        globals.currentTrainingPlan.commentIds = [];
        globals.currentTrainingPlan.userIds = [];
        globals.currentTrainingPlan.trainingDays = [];
        //print(globals.currentTrainingPlan.toJson());
        //currTrainer.trainingPlans.add(currentTrainingPlan);
        
      }
      else{
        print(response.body);
      }

  }


  Future<void> deleteTrainingPlan(String id) async{

    var client = http.Client();

    try{

        var response = await client.delete(Uri.parse("$api/api/v1/trainingPlan/delete/$id"));

        if(response.statusCode == 200){
          print("Training Plan Deleted");
          globals.trainingPlansCurrTrainer.removeWhere((element) => element.id == id);
          globals.allTrainingPlans.removeWhere((element) => element.id == id);
          globals.trainingPlansCurrUser.removeWhere((element) => element.id == id);
          globals.currTrainer.trainingPlans.removeWhere((element) => element.id == id);
          globals.currTrainer.fitnessProgrammes.remove(id);
        }


    }catch(err){
      print("deleteTrainingPlan");
      print(err);
    }

  }

  Future<TrainingPlan> getTrainingPlanById(String id) async{

    var client = http.Client();
    String api = globals.API_ardress;
    TrainingPlan trainingPlan = TrainingPlan();
    try{

      var response = await client.get(Uri.parse("$api/api/v1/trainingPlan/findById/$id"));

      if(response.statusCode == 200){

        var jsonString = response.body;
        var tp = jsonDecode(jsonString);

        trainingPlan.id = tp['id'];
        trainingPlan.name = tp['name'];
        trainingPlan.duration = tp['duration'];
        trainingPlan.price = tp['price'];
        trainingPlan.trainerId = tp['trainerId'];
        
        trainingPlan.commentIds = tp['commentIds'];
        trainingPlan.userIds = tp['userIds'];
        trainingPlan.trainingDays = tp['trainingDays'];
        trainingPlan.trainingDaysList = [];

        await getTrainingDaysByTP(trainingPlan);
        try{
          print(trainingPlan.trainingDaysList);
        }
        catch(err){
          print(err);
        }

        //print(trainingPlan.commentIds);

        return trainingPlan; 
      }
      else{
        return trainingPlan;
      }




    }catch(err){
      print("getTrainingPlanById");
      print(trainingPlan);
    }

    await Future.delayed(const Duration(seconds: 1));
    
  }

  Future<List<TrainingDay>> getTrainingDaysByTP(TrainingPlan trainingPlan) async{

      var client = http.Client();
      print('GET TRAINING DAYS BY TP FOR ${trainingPlan.id} CALLED');

      try{


        String api = globals.API_ardress;
        String id_tp = trainingPlan.id;
        //print(trainingPlan.id);
        for(String id in trainingPlan.trainingDays){
          //print(id);
          //print("1");
        var response = await client.get(Uri.parse("$api/api/v1/trainingDay/findById/$id"));

        if(response.statusCode == 200){
            var jsonString = response.body;
            var td = jsonDecode(jsonString);
            //print("2");

            TrainingDay trainingDay = TrainingDay(
              id: td['id'],
              name: td['name'],
              exerciseSetIds: td['exerciseSetIds']
            );

            for(String id2 in trainingDay.exerciseSetIds){
              //print("3");
              var response2 = await client.get(Uri.parse("$api/api/v1/exerciseSet/findById/$id2"));

              if(response2.statusCode == 200){
                //print("4");
                var jsonString2 = response2.body;
                var es = jsonDecode(jsonString2);

                ExerciseSet exerciseSet = ExerciseSet(
                  id: es['id'],
                  exerciseId: es['exerciseId'],
                  sets: es['sets'],
                  reps: es['reps'],
                );
                
                Future<Exercise> exercise = Exercise_Manager().getExerciseById(exerciseSet.id);
                exercise.then((value){
                  exerciseSet.exercise = value;
                });

                trainingDay.exerciseSets.add(exerciseSet);
              }
            } 

            try{
            trainingPlan.trainingDaysList.add(trainingDay); 
            }
            catch(err){
              print("Add Training Day to Plan");
              print(err);
            } 
        }
        else{
          print(response.body);
        }
       // print("DONE");
        }


      }catch(err){
        print("getTrainingDays");
        print(err);
      }
      
      var distinct = trainingPlan.trainingDaysList.toSet().toList();
      print("DISTINCTTTTT : ${distinct}");

      trainingPlan.trainingDaysList = distinct;
      await Future.delayed(const Duration(seconds: 1));



  }

  Future<void> getAllTrainingPlans() async{
      var client = http.Client();
      String api = globals.API_ardress;
      globals.allTrainingPlans = [];
      print("GET ALL TRAINING PLANS");

      try{
        var response = await client.get(Uri.parse("$api/api/v1/trainingPlan"));

        if(response.statusCode == 200){
          var jsonString = response.body;
          var tplans = jsonDecode(jsonString);

          for(var tp in tplans){
            print("TRAINING PLAN ID = ${tp['id']}");
            TrainingPlan trainingPlan = TrainingPlan(
              id: tp['id'],
              name: tp['name'],
              trainerId: tp['trainerId'],
              trainingDays: tp['trainingDays'],
              price: tp['price'],
              duration: tp['duration'],
              commentIds: tp['commentIds'],
              userIds: tp['userIds']
            );
            print(trainingPlan.id);
            
            await TrainingPlan_Manager().getTrainingDaysByTP(trainingPlan);
            
            globals.allTrainingPlans.add(trainingPlan);
            //print(trainingPlan.trainingDaysList[0].name);
           
           
          }

        }

      }catch(err){
        print("allTrainingPlans");
        print(err);
      }
      
      //await Future.delayed(const Duration(seconds: 1));
  }

  List<TrainingPlan> searchTrainingPlan(String search){

    List<TrainingPlan> found1 = [];

    for(TrainingPlan trainingPlan in globals.allTrainingPlans){
      String name = trainingPlan.name.toLowerCase();
      String search_lower = search.toLowerCase();
      if(name.contains(search_lower)){
        found1.add(trainingPlan);
      }
    }

    return found1;

  }

  List<TrainingPlan> searchTrainingPlanByTrainer(String search){

    List<TrainingPlan> found = [];

    for(Trainer trainer in globals.allTrainers){
      String name1 = trainer.firstName + " " +trainer.lastName;
      String name2 = trainer.lastName + " " + trainer.firstName;
      print(name1);
      if(name1.toLowerCase().contains(search.toLowerCase()) || name2.toLowerCase().contains(search.toLowerCase())){
        for(TrainingPlan trainingPlan in globals.allTrainingPlans){
          if(trainingPlan.trainerId == trainer.id){
            found.add(trainingPlan);
          }
        }
      }

    }
    return found;

  }

  Future<void> buyTrainingPlan(String trainingPlanId) async{

    var client = http.Client();

    try{

      String api = globals.API_ardress;
      String id = globals.currUser.id;
     var response = await http.put(Uri.parse("$api/api/v1/users/update/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
            //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "PUT, OPTIONS"
          },
          body: jsonEncode({
            'idHelper': trainingPlanId,
          }));
      
      if(response.statusCode == 200){
        print("TRAINING PLAN BOUGHT");
        globals.currUser.trainingPlanIds.add(trainingPlanId);
        TrainingPlan trainingPlan = await TrainingPlan_Manager().getTrainingPlanById(trainingPlanId);
        globals.currUser.trainingPlansLOCAL.add(trainingPlan);
        addClientToTrainingPlan(trainingPlanId);
        print("TRAINING PLAN PAYMENT = ${trainingPlan.toJson()}");

        var response = await http.post(Uri.parse("$api/api/v1/payment/create"),
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
            "userId":globals.currUser.id,
            "trainerId":trainingPlan.trainerId,
            "trainingPlanId":trainingPlanId,
            "payment":trainingPlan.price
          }));

          if(response.statusCode == 200){
            print("PAYMENT CREATED");
          }
          else{
            print(response.body);
          }



        // await getAllTrainingPlans();
        await Trainer_Manager().getAllTrainers();
        //await API_Manager().getUser(globals.currUser.username);
      }
      else{
        print(trainingPlanId);
        print("buyTrainingPlan");
        print(response.statusCode);
      }
      
    }catch(err){
      print("ERROR FROM buyTrainingPlan / Training_Plan_Manager");
      print(err);
    }

    await Future.delayed(const Duration(seconds: 1));

  }

  List<TrainingPlan> getPopularTP(){

    int count = 0;
    List<TrainingPlan> backup = globals.allTrainingPlans;
    List<TrainingPlan> result = [];

    backup.sort(((a, b) => a.userIds.length.compareTo(b.userIds.length)*(-1)));
    print(globals.allTrainingPlans);
    print(backup);
    print(globals.allTrainingPlans);
    
    return backup.sublist(0,3);

  }


  int getOrders(TrainingPlan trainingPlan){

    try{
      return trainingPlan.userIds.length;
    }catch(err){
      print(err);
      return 0;
    }

  }

  void addClientToTrainingPlan(String trainingPlanId){

    for(TrainingPlan trainingPlan in globals.allTrainingPlans){
      if(trainingPlan.id == trainingPlanId){

        trainingPlan.userIds.add(globals.currUser.id);

      }
    }

  }

  TrainingPlan getTrainingPlanByIdLOCAL(String id){
    return globals.allTrainingPlans.firstWhere((element) => element.id == id);
  }

  

  Future<void> createAllPayments() async{

    for(TrainingPlan trainingPlan in globals.allTrainingPlans){
      for(String userId in trainingPlan.userIds){
        var response = await http.post(Uri.parse("$api/api/v1/payment/create"),
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
            "userId":userId,
            "trainerId":trainingPlan.trainerId,
            "trainingPlanId":trainingPlan.id,
            "payment":trainingPlan.price
          }));

          if(response.statusCode == 200){
            print("PAYMENT CREATED");
          }
          else{
            print(response.body);
          }

      }
    }

  }



}
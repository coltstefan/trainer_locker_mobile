import 'dart:io';

import 'package:mobile_final/constants/strings.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/Trainer.dart';
import 'package:mobile_final/models/TrainingPlan.dart';
import 'package:mobile_final/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/services/training_plan_manager.dart';

class API_Manager{


  String api = globals.API_ardress;

   Future<Users> getUser(String username) async {

     //print("1");
    var client = http.Client();
    Users currUser;

    try{
      //print("2");
      var response = await client.get(Uri.parse("$api/api/v1/users/findByUsername/$username"));
      //print(response.statusCode);
      if (response.statusCode == 200) {
       // print("3");
        var jsonString = response.body;
        //print("4");
        var u = json.decode(jsonString);
        //("5");

        Users user = Users(
              id: u['id'],
              email: u['email'],
              username: u['username'],
              firstName: u['firstName'],
              lastName: u['lastName'],
              isTrainer: u['isTrainer'],
              trainingPlanIds: u['trainingPlanIds']
        );

        for(var tp in user.trainingPlanIds){
          TrainingPlan trainingPlan = await TrainingPlan_Manager().getTrainingPlanById(tp);
          user.trainingPlansLOCAL.add(trainingPlan);
        }

          //print("COMENZI USER = ${user.trainingPlansLOCAL}");
          currUser = user;

        //print(currUser);
        globals.currUser = currUser;
        //globals.currUser.trainingPlansLOCAL = globals.currUser.trainingPlansLOCAL.reversed;
        //print(globals.currUser.trainingPlansLOCAL.length);
        return currUser;
      }
    }
    catch(Exception){
      print(Exception);
      return currUser;
    }
  }
  
  Future<void> modIsTrainer() async{
     
     Trainer currTrainer = Trainer();
     var client = http.Client();
     try{
      
         globals.currUser.isTrainer = true;
         
         var  response2 = await http.post(Uri.parse("$api/api/v1/trainer/create"),
             headers: <String, String>{
               'Content-Type': 'application/json; charset=UTF-8',
             },
             body: jsonEncode({
               'email': globals.currUser.email,
               'username': globals.currUser.username,
               'firstName': globals.currUser.firstName,
               'lastName': globals.currUser.lastName
             }));
         //print("here1");
         if(response2.statusCode == 200){
           //print("here2");
           var jsonString = response2.body;
           //print("here3");
           var t = json.decode(jsonString);
            //print("here");
           Trainer trainer = Trainer(
             username: t['username'],
             email: t['email'],
             firstName: t['firstName'],
             lastName: t['lastName'],
             id: t['id'],
             fitnessProgrammes: t['trainingPlanIds']
           );
           //print(trainer.firstName);
           globals.currTrainer = trainer;
         }
         else{
           print("modIsTrainer");
           print(response2.body);
           print(response2.statusCode);
         }
       

     }
     catch(Exception){
       print(Exception);
       //return currTrainer;
     }
  }

  Future<void> userIsTrainer(String username) async{
        
        Trainer currTrainer;

        var client = http.Client();
        

        try{
          var response = await client.get(Uri.parse("$api/api/v1/trainer/findByUsername/$username"));
          //print(response.statusCode);

          if(response.statusCode == 200){
            var jsonString = response.body;
            var t = json.decode(jsonString);
            //print(t.toString());

            Trainer trainer = Trainer(
              id: t['id'],
              username: t['username'],
              email: t['email'],
              firstName: t['firstName'],
              lastName: t['lastName'],
              fitnessProgrammes: t['trainingPlanIds']
            );

            currTrainer = trainer;

            // print(trainer.id);
            globals.currTrainer = trainer;
            // print("AICI BOULE");
            // print(trainer.fitnessProgrammes);
            
            
            

            
          }

        }catch(Exception){
          print(Exception);
         // return currTrainer;
        }

  }

  Future<void> getTrainingPlansByTrainer(String id) async{
    List<TrainingPlan> trainingPlans = [];

    var client = http.Client();
    try{
      for(int i = 0; i< globals.currTrainer.fitnessProgrammes.length; i++){
        String id = globals.currTrainer.fitnessProgrammes[i];
        var response = await client.get(Uri.parse("$api/api/v1/trainingPlan/findById/$id"));
        //print("1");

        if(response.statusCode == 200){
           var jsonString = response.body;
           var tp = json.decode(jsonString);
          //  print("2");
          //  print(tp);

           TrainingPlan trainingPlan = TrainingPlan(
            id: tp['id'],
            name: tp['name'],
            duration: tp['duration'],
            price: tp['price'],
            commentIds: tp['commentIds'],
            userIds: tp['userIds'],
            trainingDays: tp['trainingDays'],
            trainerId: tp['trainerId']
           );

          //  print("3");
           trainingPlans.add(trainingPlan);
        }

        // print("4");
        globals.currTrainer.trainingPlans = trainingPlans;
        // print("TRINING PLANS LENGTH =");
        // print(trainingPlans.length);


      }

    }catch(err){
      print("getTrainingPlans e eroarea");
      print(err);
    }


  }

  Future<Trainer> getTrainerById(String trainerId) async{

    var client = http.Client();
    String api = globals.API_ardress;
    print(trainerId);
    var response = await client.get(Uri.parse("$api/api/v1/trainer/findById/$trainerId"));

    if(response.statusCode == 200){
      var jsonString = response.body;
      var trainer = jsonDecode(jsonString);

      Trainer trainer_nou = Trainer(
        id: trainer['id'],
        username: trainer['username'],
        email: trainer['email'],
        firstName: trainer['firstName'],
        lastName: trainer['lastName'],
        fitnessProgrammes: trainer['trainingPlanIds']
      );

      for(var fp in trainer_nou.fitnessProgrammes){

        TrainingPlan tp_current = await TrainingPlan_Manager().getTrainingPlanById(fp);
        trainer_nou.trainingPlans.add(tp_current);

      }
      return trainer_nou;


    }
    else{
      print(response.statusCode);
      print(response.body);
    }



  }

  // Future<void> getTrainerName(String id) {

  //   Future<Trainer> trainer = getTrainerById(id);
  //   // String firstName = "";
  //   // String lastName = "";

  //   print(trainer.then((value) => value.firstName));

    
    

  // }


  

}
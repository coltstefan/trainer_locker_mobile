import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/services/training_plan_manager.dart';

import '../models/Trainer.dart';
import '../models/TrainingPlan.dart';

class Trainer_Manager{


    Future<void> getAllTrainers() async{
      var client = http.Client();
      String api = globals.API_ardress;
      globals.allTrainers = [];
      int count = 1;

      try{
        var response = await client.get(Uri.parse("$api/api/v1/trainer"));

        if(response.statusCode == 200){
          var jsonString = response.body;
          var trainers = jsonDecode(jsonString);

          //print("TRAINERS REQUEST LENGTH = ${trainers}");
          for(var tp in trainers){
            print(tp);
            Trainer trainer = Trainer(
              id: tp['id'],
              email: tp['email'],
              username: tp['username'],
              firstName: tp['firstName'],
              lastName: tp['lastName'],
              fitnessProgrammes: tp['trainingPlanIds'],
            );

            for(var fp in trainer.fitnessProgrammes){

                TrainingPlan tp_current = await TrainingPlan_Manager().getTrainingPlanByIdLOCAL(fp);
                trainer.trainingPlans.add(tp_current);
                try{
                  trainer.totalOrders = trainer.totalOrders + tp_current.userIds.length;
                }catch(err){
                  print(err);
                }

             }
            // print(trainer.email);;
             //print("${count} ==============================");
             //count++;
             globals.allTrainers.add(trainer);
           
          }

          //await Future.delayed(const Duration(seconds: 1));

        }

      }catch(err){
        print("getAllTrainers");
        print(err);
      }
      //print("TRAINERS LENGTH = ${globals.allTrainers.length}");
  }

  Trainer getByIdLocal(String id){


    
    for(Trainer trainer in globals.allTrainers){
      print("here");
      if(trainer.id == id){
        return trainer;
      }
    }

  }
  
  

  List<Trainer> getPopularTrainers(){

    List<Trainer> backup = globals.allTrainers;
    
    backup.sort(((a, b) => a.totalOrders.compareTo(b.totalOrders)*(-1)));

    return backup.sublist(0,3);
      

   }

   int getTotalOrders(Trainer trainer){
    int sum = 0;
     try{

       for(TrainingPlan trainingPlan in trainer.trainingPlans){
         sum+=TrainingPlan_Manager().getOrders(trainingPlan);
       }
       return sum;

     }
     catch(err){
       print(err);
       return 0;
     }
   }
   
   double getTotalEarnings(){
     
     double total = 0;
     
     for(TrainingPlan trainingPlan in globals.currTrainer.trainingPlans){
       total = total + trainingPlan.userIds.length*trainingPlan.price;
     } 

     return total;

   }

   List<TrainingPlan> trainingPlanOrderHistory(){

     List<TrainingPlan> result = [];

     for(TrainingPlan trainingPlan in globals.currTrainer.trainingPlans){
       for(String userId in trainingPlan.userIds){
         result.insert(0, trainingPlan);
       }
     } 
     return result;

   }


}
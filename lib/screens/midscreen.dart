import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/screens/dashboard.dart';

import '../services/api_manager.dart';
import '../services/exercise_manager.dart';
import '../services/prog_overload_manager.dart';
import '../services/trainer_manager.dart';
import '../services/training_plan_manager.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;

class Midscreen extends StatefulWidget {
  const Midscreen({ Key key }) : super(key: key);

  @override
  State<Midscreen> createState() => _MidscreenState();
}

class _MidscreenState extends State<Midscreen> {

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    // if(globals.currTrainer != null){
    //         API_Manager().getTrainingPlansByTrainer(globals.currTrainer.id);
    //         // print("initSTATE");
    //         // print(globals.currTrainer.trainingPlans.length);
    //         Exercise_Manager().getAllExercises();
    //     }
    //     Exercise_Manager().getAllExercises();
    //     TrainingPlan_Manager().getAllTrainingPlans();
    //     //await Future.delayed(const Duration(seconds: 1));
    //     Trainer_Manager().getAllTrainers();
    //     //await Future.delayed(const Duration(seconds: 1));
    //     // print("ALL TRAINERS LENGTH ${globals.allTrainers.length}");
    //     print("ALL TP LENGTH ${globals.allTrainingPlans.length}");
    //     API_Manager().getUser(globals.currUser.username);

        Timer(Duration(seconds: 1), () async{
            if(globals.currTrainer != null){
            await API_Manager().getTrainingPlansByTrainer(globals.currTrainer.id);
            }
            await Exercise_Manager().getAllExercises();
            await TrainingPlan_Manager().getAllTrainingPlans();
            //await Future.delayed(const Duration(seconds: 1));
            await Trainer_Manager().getAllTrainers();
            //await Future.delayed(const Duration(seconds: 1));
            // print("ALL TRAINERS LENGTH ${globals.allTrainers.length}");
            await API_Manager().getUser(globals.currUser.username);
            await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> 
            Dashboard()));
            });
        super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/2-30,),
              CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(text: "Loading Data..." , size: 20, weight: FontWeight.bold, color: globals.textColor2,),
              )
            ],
          ),
        ),

      )
      
    );
  }
}
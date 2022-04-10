import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/models/TrainingDay.dart';
import 'package:mobile_final/models/TrainingPlan.dart';
import 'package:mobile_final/screens/add_day.dart';
import 'package:mobile_final/screens/add_training_plan.dart';
import 'package:mobile_final/screens/trainer_locker.dart';
import 'package:mobile_final/services/api_manager.dart';
import 'package:mobile_final/services/exercise_manager.dart';
import 'package:mobile_final/services/training_plan_manager.dart';

class AddTrainingDays extends StatefulWidget {
  const AddTrainingDays({ Key key }) : super(key: key);

  @override
  State<AddTrainingDays> createState() => _AddTrainingDaysState();
}

class _AddTrainingDaysState extends State<AddTrainingDays> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            TrainingPlan_Manager().deleteTrainingPlan(globals.currentTrainingPlan.id);
            changeScreen(context, AddTrainingPlan());
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: CustomText(text: "Add Training Days", color: Colors.white, size: 20, weight: FontWeight.bold,),
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
           onPressed: ()async{
                globals.currentTrainingPlan.trainingDaysList = globals.currentTrainingDays;
                globals.currTrainer.trainingPlans.add(globals.currentTrainingPlan);
                globals.currTrainer.fitnessProgrammes.add(globals.currentTrainingPlan.id);

                Exercise_Manager().saveTrainingDays(globals.currentTrainingDays, globals.currentTrainingPlan);
                await Future.delayed(const Duration(seconds: 3) , (){});



                globals.currentTrainingDays = [];
                globals.currExerciseSets = [];
                globals.currentTrainingDay = TrainingDay();
                globals.currentTrainingPlan = TrainingPlan();
                changeScreen(context, TrainerLocker());
           },
           icon: Icon(Icons.done))
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Bubble(
              radius: Radius.circular(0),
              color: Colors.deepPurpleAccent,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 100),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                    )
                ),
                child: CustomText(text: "${globals.currentTrainingPlan.name}" ,weight: FontWeight.bold, size: 20, color: Colors.white,),

                )),
              ),
            ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Center(
                 child: GestureDetector(
                   onTap: (){
                     changeScreen(context, AddDay());
                   },
                   child: Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: CustomText(text: "Add Day", color: Colors.white, size: 16, weight: FontWeight.bold,)),
                             ),
                 ),
               ),
             ),
            ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: globals.currentTrainingDays.map((item) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurpleAccent,
                                blurRadius: 4,
                                offset: Offset(1,1)
                              )
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: item.name , color: Colors.deepPurpleAccent, weight: FontWeight.bold,),
                                CustomText(text: "${item.exerciseSets.length.toString()} exercises" , color: Colors.deepPurpleAccent ,  weight: FontWeight.bold,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )).toList(),
                )
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}
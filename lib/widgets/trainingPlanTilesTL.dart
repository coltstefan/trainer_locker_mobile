import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/custom_text.dart';
import '../helpers/screen_navigation.dart';
import '../models/TrainingPlan.dart';
import '../screens/trainingPlan_trainer.dart';
import '../services/training_plan_manager.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;

class TrainingPlanTilesTL extends StatefulWidget {
  const TrainingPlanTilesTL({ Key key }) : super(key: key);

  @override
  State<TrainingPlanTilesTL> createState() => _TrainingPlanTilesTLState();
}

class _TrainingPlanTilesTLState extends State<TrainingPlanTilesTL> {
  @override
  Widget build(BuildContext context) {
    TrainingPlan trainingPlan;
    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: globals.currTrainer.trainingPlans.length,
                      itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Flexible(
                              child: GestureDetector(
                                onTap: () async{
                                  
                                  print(globals.currTrainer.fitnessProgrammes.length);
                                  Future<TrainingPlan> tp = TrainingPlan_Manager().getTrainingPlanById(globals.currTrainer.fitnessProgrammes[index]);
                                  await Future.delayed(const Duration(seconds: 1) , (){});
                                  tp.then((data) {
                                    setState(() async{
                                      trainingPlan = data;
                                      print(data.toJson());
                                      TrainingPlan_Manager().getTrainingDaysByTP(trainingPlan);
                                      await Future.delayed(const Duration(seconds: 1) , (){});
                                      print("Length:");
                                      print(trainingPlan.trainingDaysList.length);
                                      changeScreen(context, TrainingPlanPageTrainer(trainingPlan: trainingPlan,));
                                    });
                                    
                                  });
                                  
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(2,0),
                                          blurRadius: 5
                                      )]
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Bubble(
                                          radius: Radius.circular(10),
                                          color: Colors.white,
                                          elevation: 0.0,
                                          child: Flexible(
                                            child: Container(
                                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2-10),
                                              child: CustomText(text: globals.currTrainer.trainingPlans[index].name, weight: FontWeight.bold, size: 16,),
                                            ),
                                          ),
                                          
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(16,0,16,4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(text: "${globals.currTrainer.trainingPlans[index].duration} min",weight: FontWeight.bold, color: Colors.deepPurpleAccent,),
                                            CustomText(text: "${globals.currTrainer.trainingPlans[index].price} USD",weight: FontWeight.bold , color: Colors.deepPurpleAccent,)
                                          ],
                                        ),
                                      ),
                                      
                                      
                                    ],
                                  ),
                                  
                                      
                                ),
                              ),
                            ),
                          );
                      },
                      );
  }
}
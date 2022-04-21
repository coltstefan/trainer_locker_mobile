import 'package:bubble/bubble.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/screens/TrainingPlanLandingPage.dart';
import 'package:mobile_final/screens/login.dart';
import 'package:mobile_final/screens/start_training.dart';
import 'package:mobile_final/screens/trainingPlan_trainer.dart';
import 'package:mobile_final/services/api_manager.dart';
import 'package:mobile_final/services/exercise_manager.dart';
import 'package:mobile_final/widgets/bottomnavigation.dart';
import 'package:mobile_final/widgets/glass_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

import '../models/Comment.dart';
import '../models/Exercise.dart';
import '../models/ExerciseSet.dart';
import '../models/Trainer.dart';
import '../models/TrainingDay.dart';
import '../models/TrainingPlan.dart';
import '../models/User.dart';
import '../services/comment_manager.dart';
import '../services/prog_overload_manager.dart';
import '../services/trainer_manager.dart';
import '../services/training_plan_manager.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<String> week = [" " , "Mon" , "Thu" , "Wed" , "Tue" , "Fri" , "Sat"  , "Sun"];
  var parser = EmojiParser();
  var fire = Emoji('fire', '🔥');
  List<TrainingPlan> popularTP = [];

  @override
    void initState(){
        super.initState();
        
        
    }
    
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: globals.containerColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavBarFb1(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox( height: 0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Welcome back,\n${globals.currUser.firstName}',
                        style: heading2.copyWith(color: globals.textColor1),
                      ),
                    ),
                   
                    IconButton(onPressed: (){
                      bool isLoggedIn = false;
                      Users currUser = Users();
                      Trainer currTrainer = Trainer();
                      List<TrainingPlan> trainingPlansCurrTrainer = [];
                      List<TrainingPlan> trainingPlansCurrUser = [];
                      List<Exercise> exercises = [];
                      List<ExerciseSet> exerciseSets = [];
                      TrainingPlan currentTrainingPlan = TrainingPlan();
                      TrainingDay currentTrainingDay = TrainingDay();
                      List<TrainingDay> currentTrainingDays = [];
                      List<Exercise> currExercises = [];
                      List<ExerciseSet> currExerciseSets = [];
                      List<TrainingPlan> allTrainingPlans = [];
                      List<Trainer> allTrainers = [];
                      
                      changeScreenReplacement(context, Login());
                    }, icon: Icon(Icons.logout_outlined, color: globals.textColor2,))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
      
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: (MediaQuery.of(context).size.width/4)*2.5,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
      
                              Colors.deepPurple,
                              Colors.deepPurpleAccent,
                              Colors.purple,
                            ]
                          )
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Today" , weight: FontWeight.bold, size: 17, color: Colors.white,),
                                    CustomText(text: "${week[DateTime.now().weekday]}" , weight: FontWeight.bold, size: 17, color: Colors.white,)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Calories Burnt ${parser.emojify(':fire:')}" , weight: FontWeight.bold, size: 17, color: Colors.white,),
                                    CustomText(text: "1200 kcal" , weight: FontWeight.bold, size: 17, color: Colors.white,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
      
      
      
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(text: "My Training Plans", color: globals.textColor2, size: 19, weight: FontWeight.bold,),
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: globals.currUser.trainingPlansLOCAL.length,
                        itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flexible(
                                child: GestureDetector(
                                  onTap: () async{
                                    
                                    try{
                                     
                                    TrainingPlan trainingPlan = await TrainingPlan_Manager().getTrainingPlanById(globals.currUser.trainingPlansLOCAL[index].id);
                                    // for(int i = 0 ; i<globals.currUser.trainingPlansLOCAL[index].trainingDaysList.length; i++){
                                    //   print(globals.currUser.trainingPlansLOCAL[index].trainingDaysList[i].name);
                                    //   for (int j = 0; j< globals.currUser.trainingPlansLOCAL[index].trainingDaysList[i].exerciseSets.length ; j++){
                                    //     try{
                                    //       globals.currUser.trainingPlansLOCAL[index].trainingDaysList[i].exerciseSets[j].exercise = await Exercise_Manager().getExerciseById(globals.currUser.trainingPlansLOCAL[index].trainingDaysList[i].exerciseSets[j].exerciseId);
                                    //       print(globals.currUser.trainingPlansLOCAL[index].trainingDaysList[i].exerciseSets[j].exercise.toJson());
                                    //     }
                                    //     catch(err){
                                    //       print(err);
                                    //     }
                                    //   }
                                    // }

                                    for(int i = 0 ; i<trainingPlan.trainingDaysList.length; i++){
                                      print(trainingPlan.trainingDaysList[i].name);
                                      for (int j = 0; j< trainingPlan.trainingDaysList[i].exerciseSets.length ; j++){
                                        try{
                                          trainingPlan.trainingDaysList[i].exerciseSets[j].exercise = await Exercise_Manager().getExerciseById(trainingPlan.trainingDaysList[i].exerciseSets[j].exerciseId);
                                          print(trainingPlan.trainingDaysList[i].exerciseSets[j].exercise.toJson());
                                        }
                                        catch(err){
                                          print(err);
                                        }
                                      }
                                    }
                                    changeScreen(context, StartTraining(trainingPlan: trainingPlan,));
                                    }
                                    catch(err){
                                      print(err);
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: globals.containerColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: globals.textColor2,
                                            offset: Offset(1,0),
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
                                            color: globals.containerColor,
                                            elevation: 0.0,
                                            child: Flexible(
                                              child: Container(
                                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2-10),
                                                child: CustomText(text: globals.currUser.trainingPlansLOCAL[index].name, weight: FontWeight.bold, size: 16, color: globals.textColor1,),
                                              ),
                                            ),
                                            
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(16,0,16,4),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(text: "${globals.currUser.trainingPlansLOCAL[index].duration} min",weight: FontWeight.bold, color: Colors.deepPurpleAccent,),
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.2,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurpleAccent,
                                                  borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CustomText(text: "Start", color: Colors.white, size: 16, weight: FontWeight.bold,),
                                                    Icon(Icons.not_started_outlined,color: Colors.white, size: 16,)
                                                  ],
                                                )),
                                              )
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
                        ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(text: "Popular Training Plans", color: globals.textColor2, size: 19, weight: FontWeight.bold,),
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: TrainingPlan_Manager().getPopularTP().length,
                        itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flexible(
                                child: GestureDetector(
                                  onTap: () async{
                                    
                                     List<Comment> commentsList = await Comments_Manager().getCommentsByTp(TrainingPlan_Manager().getPopularTP()[index].id);
                                     changeScreen(context, TrainingPlanLP(trainingPlan: TrainingPlan_Manager().getPopularTP()[index], commentsList: commentsList.reversed.toList()));
                                    
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: globals.containerColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: globals.textColor2,
                                            offset: Offset(1,0),
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
                                            color: globals.containerColor,
                                            elevation: 0.0,
                                            child: Flexible(
                                              child: Container(
                                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2-10),
                                                child: CustomText(text: TrainingPlan_Manager().getPopularTP()[index].name, weight: FontWeight.bold, size: 16, color: globals.textColor1,),
                                              ),
                                            ),
                                            
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(16,0,16,4),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(text: "${TrainingPlan_Manager().getPopularTP()[index].price} USD",weight: FontWeight.bold, color: Colors.deepPurpleAccent,),
                                              CustomText(text: "${TrainingPlan_Manager().getPopularTP()[index].userIds.length} Orders",weight: FontWeight.bold , color: Colors.deepPurpleAccent,)
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
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(text: "Popular Trainers" , size: 19, weight: FontWeight.bold, color: globals.textColor2,),
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Trainer_Manager().getPopularTrainers().length,
                        itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flexible(
                                child: GestureDetector(
                                  onTap: () async{
                                    
                                     //changeScreen(context, TrainingPlanLP(trainingPlan: TrainingPlan_Manager().getPopularTP()[index],));
                                    
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: globals.containerColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: globals.textColor2,
                                            offset: Offset(1,0),
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
                                            color: globals.containerColor,
                                            elevation: 0.0,
                                            child: Flexible(
                                              child: Container(
                                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2-10),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.account_circle_outlined , color: Colors.deepPurpleAccent ,size: 16,),
                                                    CustomText(text: " ${Trainer_Manager().getPopularTrainers()[index].firstName} ${Trainer_Manager().getPopularTrainers()[index].lastName}", weight: FontWeight.bold, size: 16, color: globals.textColor1,),                                                    
                                                  ],
                                                ),
                                              ),
                                            ),
                                            
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(16,0,16,4),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(text: "${Trainer_Manager().getPopularTrainers()[index].totalOrders} Orders",weight: FontWeight.bold , color: Colors.deepPurpleAccent,)
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
                        ),
                ),

                
              ],
            ),
          ),
      
        ),
      ),

    );
  }
}

import 'package:bubble/bubble.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/TrainingPlan.dart';
import 'package:mobile_final/screens/dashboard.dart';
import 'package:mobile_final/screens/earnings_screen.dart';
import 'package:mobile_final/screens/start.dart';
import 'package:mobile_final/screens/trainingPlan_trainer.dart';
import 'package:mobile_final/services/api_manager.dart';
import 'package:mobile_final/services/payment_service.dart';
import 'package:mobile_final/services/trainer_manager.dart';
import 'package:mobile_final/services/training_plan_manager.dart';
import 'package:mobile_final/widgets/bottomnavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/widgets/trainingPlanTilesTL.dart';

import '../helpers/screen_navigation.dart';
import 'add_training_plan.dart';

class TrainerLocker extends StatefulWidget {
  @override
  _TrainerLockerState createState() => _TrainerLockerState();
}

class _TrainerLockerState extends State<TrainerLocker> {

  @override
  Widget build(BuildContext context) {
    
   
    TrainingPlan trainingPlan;

    return Scaffold(
      bottomNavigationBar: BottomNavBarFb1(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
        leading: CustomText(text: "",),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomText(text: "${globals.currTrainer.firstName}'s Trainer Locker", size: 20, weight: FontWeight.bold, color: Colors.white,),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Welcome to your\nTrainer Locker',
                                  style: heading2.copyWith(color: Colors.white),
                                ),
                                IconButton(icon: Icon(Icons.arrow_back_outlined, color: Colors.white,), onPressed: (){
                                  changeScreen(context, Dashboard());
                                }),
                              ],
                            )
                    ),
                    GestureDetector(
                      onTap: (){
                        changeScreen(context, AddTrainingPlan());
                      },
                      child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.55,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(child: CustomText(text: "Add a Training Plan", color: Colors.deepPurpleAccent, weight: FontWeight.bold, size: 16,)),
                                    ),
                                  ),
                                ),
                    ),
        
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CustomText(text: "Your rating is 4.9", weight: FontWeight.bold, size: 16, color: Colors.white,),
                    Icon(Icons.star , color: Colors.yellow, size: 18,)
                  ],
                ),
              ),
                  ],
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomText(text: "Statistics", color: Colors.black, size: 19, weight: FontWeight.bold,),
              ),
        
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,4,16,0),
                      child: Container(
                        width: MediaQuery.of(context).size.width/2-50,
                        height: 80,
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
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Orders", weight: FontWeight.bold,),
                                  ],
                                ),
                              ),
        
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8,6,6,6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "${Trainer_Manager().getTotalOrders(globals.currTrainer)}" , color: Colors.deepPurpleAccent, weight: FontWeight.bold, size: 15,),
                                    Row(
                                      children: [
                                        Icon(Icons.arrow_upward , color: Colors.green, size: 13,),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,4,16,0),
                      child: Container(
                        width: MediaQuery.of(context).size.width/2-50,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2,0),
                              blurRadius: 5
                          )]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Earnings" , weight: FontWeight.bold,),
                                  ],
                                ),
                              ),
        
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "${Trainer_Manager().getTotalEarnings()} USD" , color: Colors.deepPurpleAccent, weight: FontWeight.bold, size: 15,),
                                    Row(
                                      children: [
                                        Icon(Icons.arrow_upward , color: Colors.green, size: 13,),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomText(text: "Training Plans", color: Colors.black, size: 19, weight: FontWeight.bold,),
              ),
             
              Padding(
                padding: const EdgeInsets.fromLTRB(16,2,16,2),
                child: Flexible(
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 130),
                    //height: 130,
                    child: globals.currTrainer.trainingPlans.length == 0 ? 
                    Center(child: CustomText(text: "No Training Plans Added")) :
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: globals.currTrainer.trainingPlans.length,
                      itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Flexible(
                              child: GestureDetector(
                                onTap: () async{
                                  
                                  print(globals.currTrainer.fitnessProgrammes);
                                  print(globals.currTrainer.fitnessProgrammes[index]);
                                  Future<TrainingPlan> tp = TrainingPlan_Manager().getTrainingPlanById(globals.currTrainer.fitnessProgrammes[index]);
                                  await Future.delayed(const Duration(seconds: 1) , (){});
                                  tp.then((data) {
                                    setState(() async{
                                      trainingPlan = data;
                                      print(data.toJson());
                                      //await TrainingPlan_Manager().getTrainingDaysByTP(trainingPlan);
                                      //await Future.delayed(const Duration(seconds: 1) , (){});
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
                      ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Earnings", color: globals.textColor1, size: 21, weight: FontWeight.bold,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      height: 30,
                      decoration: BoxDecoration(
                        color: globals.textPurple,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: globals.textColor2,
                            blurRadius: 3,
                            offset: Offset(1,1)
                          ),
                        ]
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async{
                            await PaymentManager().getPaymentsByCurrTrainer();
                            changeScreen(context, EarningsScreen(trainingPlans: Trainer_Manager().trainingPlanOrderHistory(),));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               CustomText(text: "See Earnings", color: Colors.white, size: 19, weight: FontWeight.bold,),
                               SizedBox(width: 5,),
                               Icon(Icons.auto_graph , color: Colors.white, size: 19,)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
              
        
        
              
              
              
              
            ],
          ),
        ),
      ),
    );
  }
}

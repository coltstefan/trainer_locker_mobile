import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/models/TrainingPlan.dart';
import 'package:mobile_final/screens/trainer_locker.dart';
import 'package:mobile_final/services/training_plan_manager.dart';
import 'package:mobile_final/widgets/TrainingDayTile.dart';
import 'package:mobile_final/widgets/trainingPlanTilesTL.dart';

class TrainingPlanPageTrainer extends StatefulWidget {
  const TrainingPlanPageTrainer({ Key key ,  this.trainingPlan}) : super(key: key);

  final TrainingPlan trainingPlan;


  @override
  State<TrainingPlanPageTrainer> createState() => _TrainingPlanPageTrainerState();
}

class _TrainingPlanPageTrainerState extends State<TrainingPlanPageTrainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: CustomText(text: "My Training Plan", size: 17, color: Colors.white, weight: FontWeight.bold,),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.07,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(2,1)
                      )
                    ]
                  ),
                  child: Center(child: CustomText(text: widget.trainingPlan.name, size: 17, color: Colors.white, weight: FontWeight.bold,)),
                ),
                
                Column(
                  children: widget.trainingPlan.trainingDaysList.map((item) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TrainingDayTile(trainingDay: item,)
                    )).toList(),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0,8,0,8),
                  child: GestureDetector(
                    onTap: () async{

                      await TrainingPlan_Manager().deleteTrainingPlan(widget.trainingPlan.id);
                      changeScreen(context, TrainerLocker());

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(0)
                      ),
                      child: Center(child: CustomText(text: "Delete Training Plan", color: Colors.white, size: 19, weight: FontWeight.bold,)),
                  
                    ),
                  ),
                ),

                SizedBox(height: 50,),
          
            ]
          ),
        ),
      ),
    );
  }
}
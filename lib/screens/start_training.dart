import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/models/TrainingPlan.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/screens/Exercise_Set_page.dart';
import 'package:mobile_final/screens/dashboard.dart';

class StartTraining extends StatefulWidget {
  const StartTraining({ Key key , this.trainingPlan}) : super(key: key);

  final TrainingPlan trainingPlan;

  @override
  State<StartTraining> createState() => _StartTrainingState();
}

class _StartTrainingState extends State<StartTraining> {


  double height = 130;
  String text = "Preview Exercises";
  Icon icon = Icon(Icons.subdirectory_arrow_right ,color: globals.textColor2, size: 16,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: globals.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: globals.textColor2, size: 18,),
          onPressed: () => changeScreen(context, Dashboard()),
        ),
        centerTitle: true,
        title: CustomText(text: widget.trainingPlan.name, size: 18, color: globals.textColor1, weight: FontWeight.bold,),
      ),
      backgroundColor: globals.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: widget.trainingPlan.trainingDaysList.map((item) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: globals.containerColor,
                        ),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: globals.containerColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: globals.textColor2,
                                blurRadius: 4,
                                offset: Offset(1,1)
                              )
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(text: item.name , color: globals.textPurple, weight: FontWeight.bold,),
                                            SizedBox(height: 10,),
                                            CustomText(text: "${item.exerciseSets.length.toString()} exercises" , color: globals.textPurple ,  weight: FontWeight.bold,),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: (){
                                            changeScreen(context, ExerciseSetPage(index: 0, exerciseSets: item.exerciseSets,));
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: globals.textPurple,
                                              borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Center(
                                              child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            CustomText(text: "Start", color: globals.containerColor, size: 16, weight: FontWeight.bold,),
                                                            Icon(Icons.not_started_outlined ,color: Colors.white, size: 16,)
                                                          ],
                                                        ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8,8,0,0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          if(height == 130){
                                            height = 170;
                                            text = "Hide Exercises";
                                            icon = Icon(Icons.keyboard_arrow_down ,color: globals.textColor2, size: 18,);
                                          }
                                          else{
                                            height = 130;
                                            text = "Preview Exercises";
                                            icon = Icon(Icons.subdirectory_arrow_right ,color: globals.textColor2, size: 18,);
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          icon,
                                          CustomText(text: text , color: globals.textColor2, size: 17, weight: FontWeight.bold,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  height == 130 ? Container(
                                    child: CustomText(text: "",size: 3,),
                                  ): Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.8,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            color: globals.textColor2,
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: null,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 40,
                                        child: ListView.builder(
                                          itemCount: item.exerciseSets.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context,index){
                                            return Padding(
                                              padding: const EdgeInsets.fromLTRB(12,8,8,8),
                                              child: CustomText(text: item.exerciseSets[index].exercise.name, weight: FontWeight.bold ,color: globals.textColor2,),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
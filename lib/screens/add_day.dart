import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/models/ExerciseSet.dart';
import 'package:mobile_final/models/TrainingDay.dart';
import 'package:mobile_final/screens/add_training_days.dart';
import 'package:mobile_final/services/exercise_manager.dart';

import '../models/Exercise.dart';

class AddDay extends StatefulWidget {
  const AddDay({ Key key }) : super(key: key);

  @override
  State<AddDay> createState() => _AddDayState();
}

class _AddDayState extends State<AddDay> {
  @override

  var nameController = TextEditingController();
  var setsController = TextEditingController();
  var repsController = TextEditingController();
  var notesController = TextEditingController();
  String selectedExercise = "622b6496e1f79364d09a19a4";

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            globals.currExerciseSets = [];
            changeScreen(context, AddTrainingDays());
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: CustomText(text: "Create Day", size: 20, weight: FontWeight.bold,color: Colors.white,),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async{
                TrainingDay trainingDay = TrainingDay(
                  name: nameController.text,
                );
                trainingDay.exerciseSets = globals.currExerciseSets;
                Exercise_Manager().saveExerciseSets(globals.currExerciseSets, trainingDay);
                await Future.delayed(const Duration(seconds: 3) , (){});
                //(globals.currentTrainingDay);
                globals.currentTrainingDays.add(trainingDay);
                globals.currExerciseSets = [];
                changeScreen(context, AddTrainingDays());
              },
              icon: Icon(Icons.done)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                              decoration: BoxDecoration(
                                color: textWhiteGrey,
                                borderRadius: BorderRadius.circular(14)
                              ),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'Day Name',
                                  hintStyle: heading6.copyWith(color: textGrey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )
                                ),
                              ),
                            ),
                  ),
                 
             Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.33,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))
                                  ),
                                  child: Center(child: CustomText(text: "Add Set", color: Colors.white, size: 15, weight: FontWeight.bold,)),
                                ),
                                DropdownButton(
                                  value: selectedExercise,
                                  icon: const Icon(Icons.keyboard_arrow_down),   
                                  items: globals.exercises.map((Exercise exercise) {
                                          return DropdownMenuItem<String>(
                                          value: exercise.id,
                                          child: Text(exercise.name),
                                        );
                                      }).toList(), 
                                  onChanged: (String newValue){
                                    setState(() {
                                      selectedExercise = newValue;
                                      print(selectedExercise);
                                    });
                                      
                                  }
                                  ),
                                Container(
                                  decoration: BoxDecoration(
                                 color: textWhiteGrey,
                                   borderRadius: BorderRadius.circular(0)
                                  ),
                            child: TextFormField(
                              controller: setsController,
                              decoration: InputDecoration(
                                hintText: 'Sets',
                                hintStyle: heading6.copyWith(color: textGrey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                         
                          Container(
                                  decoration: BoxDecoration(
                                 color: textWhiteGrey,
                                   borderRadius: BorderRadius.circular(0)
                                  ),
                            child: TextFormField(
                              controller: repsController,
                              decoration: InputDecoration(
                                hintText: 'Repetitions',
                                hintStyle: heading6.copyWith(color: textGrey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Container(
                                  decoration: BoxDecoration(
                                 color: textWhiteGrey,
                                   borderRadius: BorderRadius.circular(0)
                                  ),
                            child: TextFormField(
                              controller: notesController,
                              decoration: InputDecoration(
                                hintText: 'Notes',
                                hintStyle: heading6.copyWith(color: textGrey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                
                              ),
                             
                            ),
                          ),
                          
                              ],
                            ),
                         ),
              Padding(
               padding: const EdgeInsets.all(8.0),
               child: Center(
                 child: GestureDetector(
                   onTap: (){
                     ExerciseSet exerciseSet = ExerciseSet(
                        exerciseId: selectedExercise,
                        sets: int.parse(setsController.text),
                        reps: int.parse(repsController.text)
                     );
                     setState(() {
                       globals.currExerciseSets.add(exerciseSet);
                     });
        
                   },
                   child: Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Center(child: CustomText(text: "Add", color: Colors.white, size: 16, weight: FontWeight.bold,)),
                             ),
                 ),
               ),
             ),
        
                  
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: globals.currExerciseSets.length,
                  itemBuilder: (BuildContext context,int index){
                        return  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                                  width: MediaQuery.of(context).size.width*0.44,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3,
                                        offset: Offset(1,1)
                                      )
                                    ]
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                             Padding(
                                               padding: const EdgeInsets.all(8.0),
                                               child: CustomText(text: "${Exercise_Manager().getExerciseName(globals.currExerciseSets[index].exerciseId)}" , color: Colors.black, size: 16, weight: FontWeight.bold,),
                                             ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(text: "${globals.currExerciseSets[index].sets} sets"  , color: Colors.deepPurpleAccent, size: 19, weight: FontWeight.bold,),
                                              CustomText(text: "${globals.currExerciseSets[index].reps} reps"  , color: Colors.deepPurpleAccent, size: 19, weight: FontWeight.bold,)
                                            ],
                                          ),
                                        )
                                    ],
                                  )
                                ),
                        );
                  }),
              )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
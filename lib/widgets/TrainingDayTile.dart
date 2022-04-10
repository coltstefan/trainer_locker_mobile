import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/TrainingDay.dart';

import '../helpers/custom_text.dart';
import '../services/exercise_manager.dart';

class TrainingDayTile extends StatefulWidget {
  const TrainingDayTile({ Key key ,  this.trainingDay}) : super(key: key);

  final TrainingDay trainingDay;
  final Color text = Colors.black87;
  final Color container = Colors.white;

  @override
  State<TrainingDayTile> createState() => _TrainingDayTileState();
}

class _TrainingDayTileState extends State<TrainingDayTile> {
  bool showSets = false;
  double height = 111;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      Flexible(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          constraints: BoxConstraints(maxHeight: 175),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey,
            //     offset: Offset(1,0),
            //     blurRadius: 3
            //   )
            // ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: widget.trainingDay.name , size: 22, weight: FontWeight.bold, color: Colors.black54  ,),
                    CustomText(text: "${widget.trainingDay.exerciseSets.length} exercises" , size: 22, weight: FontWeight.bold, color: Colors.black45,)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: widget.text,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: CustomText(text: "",),
                  ),
                ),
               
                showSets == true ? Container(
                    height: 100,
                    child:  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.trainingDay.exerciseSets.length,
                      itemBuilder: (BuildContext context,int index){
                            return  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                      width: MediaQuery.of(context).size.width*0.44,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade200,
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: widget.text,
                                        //     blurRadius: 3,
                                        //     offset: Offset(1,1)
                                        //   )
                                        // ]
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                 Padding(
                                                   padding: const EdgeInsets.all(8.0),
                                                   child: CustomText(text: "${Exercise_Manager().getExerciseName(widget.trainingDay.exerciseSets[index].exerciseId)}" , color: widget.text, size: 18, weight: FontWeight.bold,),
                                                 ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomText(text: "${widget.trainingDay.exerciseSets[index].sets} sets of ${widget.trainingDay.exerciseSets[index].reps} reps"  , color: widget.text, size: 19, weight: FontWeight.bold,),
                                                  //CustomText(text: "${widget.trainingDay.exerciseSets[index].reps} reps"  , color: Colors.deepPurpleAccent, size: 19, weight: FontWeight.bold,)
                                                ],
                                              ),
                                            )
                                        ],
                                      )
                                    ),
                            );
                      }) ,
                  ) : GestureDetector(
                    onTap: (){
                     setState(() {
                        height = 175;
                        showSets = true;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.keyboard_arrow_right_outlined),
                        CustomText(text: "Expand Exercise Sets"),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ) 
    );
                           
  }
}
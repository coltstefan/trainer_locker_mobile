import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/models/Comment.dart';
import 'package:mobile_final/screens/TrainingPlanLandingPage.dart';
import 'package:mobile_final/services/api_manager.dart';
import 'package:mobile_final/services/comment_manager.dart';
import 'package:mobile_final/services/trainer_manager.dart';

import '../helpers/custom_text.dart';
import '../models/Trainer.dart';
import '../models/TrainingPlan.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;

class SearchResult extends StatefulWidget {
  const SearchResult({Key key, this.trainingPlan}) : super(key: key);

  final TrainingPlan trainingPlan;
  




  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult>{
  
  Trainer trainer = new Trainer();

  @override
  void initState() {
    super.initState();
    //trainer = Trainer_Manager().getByIdLocal(widget.trainingPlan.trainerId);
    //print(trainer.toJson());
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        List<Comment> commentsList = await Comments_Manager().getCommentsByTp(widget.trainingPlan.id);
        changeScreen(context, TrainingPlanLP(trainingPlan: widget.trainingPlan, commentsList: commentsList,));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.white,
          ),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.circular(0),
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.black,
                //       blurRadius: 2,
                //       offset: Offset(1, 1))
                // ]
              border: Border(
              left: BorderSide(width: 2.0, color: Colors.deepPurpleAccent.shade400),
              bottom: BorderSide(width: 1.0, color: Colors.deepPurpleAccent.shade400),
            ),
                ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: widget.trainingPlan.name,
                    color: Colors.deepPurpleAccent,
                    weight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      CustomText(text: "by ",weight: FontWeight.bold,color: Colors.black54),
                      CustomText(
                        text:
                            "${Trainer_Manager().getByIdLocal(widget.trainingPlan.trainerId).firstName} ",
                        size: 16,color: Colors.black54,weight: FontWeight.bold,
                      ),
                      CustomText(
                        text:
                            "${Trainer_Manager().getByIdLocal(widget.trainingPlan.trainerId).lastName}",
                        size: 16, color: Colors.black54,weight: FontWeight.bold,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

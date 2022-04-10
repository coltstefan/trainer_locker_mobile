import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/ExerciseSet.dart';
import 'package:mobile_final/screens/Exercise_Set_page.dart';
import 'package:mobile_final/screens/dashboard.dart';

import '../widgets/exercise_set_page_animation.dart';

class AnimatedExerciseSet extends StatelessWidget {
  AnimatedExerciseSet({Key key, @required AnimationController controller , this.index,this.exerciseSetList})
      : animation = ExerciseSetPageAnimation(controller),
        super(key: key);

  final ExerciseSetPageAnimation animation;
  final int index;
  final List<ExerciseSet> exerciseSetList; 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: animation.controller,
        builder: (context, child) => _buildAnimation(context, child, size),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child, Size size) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: Stack(clipBehavior: Clip.none, children: [
            topBar(animation.barHeight.value),
            ExerciseName(size, animation.avatarSize.value)
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Opacity(
                  opacity: animation.titleOpacity.value,
                  child: placeHolderBox(28, 150, Alignment.centerLeft , "${exerciseSetList[index].sets} sets" )),
              Opacity(
                  opacity: animation.titleOpacity.value,
                  child: placeHolderBox(28, 150, Alignment.centerRight , "${exerciseSetList[index].reps} reps" )),
              SizedBox(
                height: 8,
              ),
              Opacity(
                  opacity: animation.textOpacity.value,
                  child: placeHolderBox(
                      180, double.infinity, Alignment.centerLeft , "${exerciseSetList[index].exercise.description}" )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      changeScreen(context, ExerciseSetPage(exerciseSets: exerciseSetList,index: index-1,));
                    },
                    child: Opacity(
                        opacity: animation.textOpacity.value,
                        child: index != 0 ? placeHolderBox(28, 150, Alignment.centerLeft , "Previous" ) : null),
                  ),
                  GestureDetector(
                    onTap: (){
                       changeScreen(context, ExerciseSetPage(exerciseSets: exerciseSetList,index: index+1,));

                    },
                    child: Opacity(
                        opacity: animation.textOpacity.value,
                        child: index != exerciseSetList.length-1 ? placeHolderBox(28, 150, Alignment.centerRight , "Next" ) : null),
                  ),
                ],
              ),
              SizedBox(height: 30,),
               GestureDetector(
                    onTap: (){
                       changeScreen(context, Dashboard());

                    },
                    child: Opacity(
                        opacity: animation.textOpacity.value,
                        child: exitButton(28, 50, Alignment.center , "Exit" )),
                  ),
            ],
          ),
        )
      ],
    );
  }

  Container topBar(double height) {
    return Container(
      height: height,
      width: double.infinity,
      color: globals.textPurple,
      child: Center(
        child: CustomText(text: "Exercise ${index + 1}", color: Colors.white, size: 20, weight: FontWeight.bold,),
      ),
    );

  }

  Positioned ExerciseName(Size size, double animationValue) {
    return Positioned(
        top: 220,
        left: size.width / 2 - 100,
        child: Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.diagonal3Values(animationValue, animationValue, 1.0),
          child: Container(
            height: 60,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: globals.textColor2,
                      blurRadius: 3,
                      offset: Offset(1, 1))
                ]),
                child: Center(child: CustomText(text: exerciseSetList[index].exercise.name,color: globals.textColor2, weight: FontWeight.bold, size: exerciseSetList[index].exercise.name.length < 18 ? 18 : 15,)),
          ),
        ));
  }

  Align placeHolderBox(double height, double width, Alignment alignment, String text) {
    return Align(
      alignment: alignment,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300),
        child: Center(child: CustomText( text: text, color: globals.textColor2, weight: FontWeight.bold,)),
      ),
    );
  }

  Align exitButton(double height, double width, Alignment alignment, String text) {
    return Align(
      alignment: alignment,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red),
        child: Center(child: CustomText( text: text, color: Colors.white, weight: FontWeight.bold,)),
      ),
    );
  }
}

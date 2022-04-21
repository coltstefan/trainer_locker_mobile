import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/screens/add_progressive_overload.dart';
import 'package:mobile_final/screens/edit_prog_over.dart';
import 'package:mobile_final/services/exercise_manager.dart';
import 'package:mobile_final/widgets/bottomnavigation.dart';

import '../models/ProgressiveOverload.dart';

class ProgressiveOverload extends StatefulWidget {
  const ProgressiveOverload({Key key}) : super(key: key);

  @override
  State<ProgressiveOverload> createState() => _ProgressiveOverloadState();
}

class _ProgressiveOverloadState extends State<ProgressiveOverload> {
  List<String> lista = ["1", "1", "1", "1", "1", "1", "1"];
  String text = "";
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarFb1(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Progressive\nOverload",
                    color: globals.textColor2,
                    weight: FontWeight.bold,
                    size: 22,
                  ),
                  IconButton(onPressed: (){
                    changeScreen(context, AddProgOverload());
                  }, 
                  icon: Icon(Icons.add , size: 30, color: globals.textColor2,))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomText(
                text:
                    "Keep track of your performance for different exercises and try to beat your results",
                color: globals.textColor2,
                weight: FontWeight.bold,
                size: 17,
              ),
            ),
            globals.allProgressiveOverloads.isNotEmpty
                ? ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: globals.allProgressiveOverloads
                            .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: exerciseCard(e),
                                ))
                            .toList(),
                      )
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CustomText(
                              text:
                                  "You have not used Progressive Overload yet",
                              color: globals.textColor2,
                              weight: FontWeight.bold,
                              size: 15,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (clicked == false) {
                                      clicked = true;
                                      text =
                                          "Add the exercises you perform during training, and record the amount of Sets, Repetitions and the Weight you do them with.";
                                    } else {
                                      clicked = false;
                                      text = "";
                                    }
                                  });
                                },
                                icon: Icon(Icons.info))
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: text,
                          color: globals.textColor2,
                          weight: FontWeight.bold,
                          size: 15,
                        ),
                      ),
                      //Center(child: CustomText(text: "Add the exercises you perform during training, and record the amount of Sets, Repetitions and the Weight you do them with." , color: globals.textColor2, weight: FontWeight.bold, size: 15,),),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Container exerciseCard(ProgressiveOverloadModel element) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 110,
      decoration: BoxDecoration(
          color: textWhiteGrey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(2, 1), color: globals.textColor2, blurRadius: 3)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: Exercise_Manager().getExerciseName(element.exerciseId),
                  weight: FontWeight.bold,
                  color: globals.textPurple,
                  size: 20,
                ),
                IconButton(
                    onPressed: () {
                      changeScreen(
                          context,
                          EditProgressOverload(
                            progressiveOverloadModel: element,
                          ));
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 20,
                      color: globals.textPurple,
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "${element.sets} Sets",
                  weight: FontWeight.bold,
                  color: globals.textColor2,
                  size: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "${element.reps} Reps",
                  weight: FontWeight.bold,
                  color: globals.textColor2,
                  size: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "${element.weight} Kg",
                  weight: FontWeight.bold,
                  color: globals.textPurple,
                  size: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

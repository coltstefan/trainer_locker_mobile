import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/Exercise.dart';
import 'package:mobile_final/models/ProgressiveOverload.dart';
import 'package:mobile_final/screens/progressive_overload.dart';
import '../helpers/custom_text.dart';
import '../helpers/globals.dart' as globals;
import '../models/ProgressiveOverload.dart';
import 'package:http/http.dart' as http;

class AddProgOverload extends StatefulWidget {
  const AddProgOverload({Key key}) : super(key: key);

  @override
  State<AddProgOverload> createState() => _AddProgOverloadState();
}

class _AddProgOverloadState extends State<AddProgOverload> {
  var setsController = TextEditingController();
  var repsController = TextEditingController();
  var weightController = TextEditingController();
  String selectedExercise = "622b6496e1f79364d09a19a4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: globals.textColor2,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  ProgressiveOverloadModel progressiveOverloadModel =
                      ProgressiveOverloadModel(
                          userId: globals.currUser.id,
                          exerciseId: selectedExercise,
                          sets: int.parse(setsController.text),
                          reps: int.parse(repsController.text),
                          weight: int.parse(weightController.text));

                  await createProgOverload(progressiveOverloadModel);
                  changeScreenReplacement(context, ProgressiveOverload());
                },
                icon: Icon(
                  Icons.done,
                  color: globals.textColor2,
                  size: 29,
                )),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: "Add Exercise Performance",
                weight: FontWeight.bold,
                size: 23,
                color: globals.textPurple,
              ),
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
                onChanged: (String newValue) {
                  setState(() {
                    selectedExercise = newValue;
                    print(selectedExercise);
                  });
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "Number of sets",
                          color: globals.textPurple,
                          weight: FontWeight.bold,
                          size: 18,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextFormField(
                          controller: setsController,
                          decoration: InputDecoration(
                              hintText: 'Number of Sets',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "Number of reps",
                          color: globals.textPurple,
                          weight: FontWeight.bold,
                          size: 18,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextFormField(
                          controller: repsController,
                          decoration: InputDecoration(
                              hintText: 'Number of repetitions',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "Weight",
                          color: globals.textPurple,
                          weight: FontWeight.bold,
                          size: 18,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextFormField(
                          controller: weightController,
                          decoration: InputDecoration(
                              hintText: "Weight",
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createProgOverload(ProgressiveOverloadModel element) async {
    var client = http.Client();

    try {
      String api = globals.API_ardress;
      print("1");
      var response =
          await http.post(Uri.parse("$api/api/v1/progressiveOverload/create"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                "Access-Control-Allow-Origin":
                    "*", // Required for CORS support to work
                //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
                "Access-Control-Allow-Headers":
                    "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
                "Access-Control-Allow-Methods": "POST, OPTIONS"
              },
              body: jsonEncode({
                "userId": element.userId,
                "exerciseId": element.exerciseId,
                "weight": element.weight,
                "reps": element.reps,
                "sets": element.sets
              }));
      
      if(response.statusCode == 200){

        globals.allProgressiveOverloads.add(element);
        print("PROGRESSIVE OVERLOAD ADDED");

      }
      else{

      }

    } catch (err) {
      print("CREATE PROG OVERLOAD");
      print(err);
    }
  }
}

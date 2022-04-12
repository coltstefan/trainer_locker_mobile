import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/models/TrainingPlan.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/screens/trainer_locker.dart';
import 'package:mobile_final/services/api_manager.dart';
import 'package:mobile_final/services/training_plan_manager.dart';

import '../helpers/theme.dart';

class EditTrainingPlan extends StatefulWidget {
  const EditTrainingPlan({Key key, this.trainingPlan}) : super(key: key);

  final TrainingPlan trainingPlan;

  @override
  State<EditTrainingPlan> createState() => _EditTrainingPlanState();
}

class _EditTrainingPlanState extends State<EditTrainingPlan> {
  var nameController = TextEditingController();
  var durationController = TextEditingController();
  var priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    nameController.text = widget.trainingPlan.name;
    durationController.text = widget.trainingPlan.duration.toString();
    priceController.text = widget.trainingPlan.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globals.containerColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            CustomText(
              text: "Update your Training Plan",
              weight: FontWeight.bold,
              size: 23,
              color: globals.textColor2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14)),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: 'Training Plan Name',
                          hintStyle: heading6.copyWith(color: textGrey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14)),
                    child: TextFormField(
                      controller: durationController,
                      decoration: InputDecoration(
                          hintText: 'Duration',
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
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: textWhiteGrey,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                          hintText: "Price",
                          hintStyle: heading6.copyWith(color: textGrey),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GestureDetector(
                  onTap: () async{

                    TrainingPlan trainingPlan = TrainingPlan(
                      id: widget.trainingPlan.id,
                      name: nameController.text,
                      duration: int.parse(durationController.text),
                      price: double.parse(priceController.text)
                    );

                    await updateTrainingPlan(trainingPlan);
                    await TrainingPlan_Manager().getAllTrainingPlans();
                    await API_Manager().getTrainingPlansByTrainer(globals.currTrainer.id);
                    changeScreen(context, TrainerLocker());

                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 50,
                    decoration: BoxDecoration(
                      color: globals.textPurple,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: CustomText(text: "Submit Changes", weight:FontWeight.bold, color: textWhiteGrey, size: 18,),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<TrainingPlan>updateTrainingPlan(TrainingPlan trainingPlan) async{

    var client = http.Client(); 

    try{

      String api = globals.API_ardress;
      String id = trainingPlan.id;

      var response = await http.put(Uri.parse("$api/api/v1/trainingPlan/editPlan/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
            //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "PUT, OPTIONS"
          },
          body: jsonEncode({
            'id': trainingPlan.id,
            'name':trainingPlan.name,
            'duration':trainingPlan.duration,
            'price':trainingPlan.price
          }));
      
      if(response.statusCode == 200){

        print("Training Plan Edited");

      }
      else{
        print(response.statusCode);
        print(response.body);
      }

    }
    catch(err){
      print(err);
    }

  }
}

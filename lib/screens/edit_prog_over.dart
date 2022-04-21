import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/ProgressiveOverload.dart';
import 'package:mobile_final/screens/progressive_overload.dart';
import 'package:mobile_final/services/prog_overload_manager.dart';
import '../helpers/globals.dart' as globals;
import 'package:http/http.dart' as http;
import '../helpers/custom_text.dart';

class EditProgressOverload extends StatefulWidget {
  const EditProgressOverload({Key key, this.progressiveOverloadModel})
      : super(key: key);

  final ProgressiveOverloadModel progressiveOverloadModel;

  @override
  State<EditProgressOverload> createState() => _EditProgressOverloadState();
}

class _EditProgressOverloadState extends State<EditProgressOverload> {
  var setsController = TextEditingController();
  var repsController = TextEditingController();
  var weightController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    setsController.text = widget.progressiveOverloadModel.sets.toString();
    repsController.text = widget.progressiveOverloadModel.reps.toString();
    weightController.text = widget.progressiveOverloadModel.weight.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: globals.textColor2,),
          onPressed: (){
            Navigator.pop(context);
          },

        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () async{
                ProgressiveOverloadModel progressiveOverloadModel = ProgressiveOverloadModel(
                  id: widget.progressiveOverloadModel.id,
                  userId: widget.progressiveOverloadModel.userId,
                  exerciseId: widget.progressiveOverloadModel.exerciseId,
                  weight: int.parse(weightController.text),
                  reps: int.parse(repsController.text),
                  sets: int.parse(setsController.text),
                );

                await updateProgressOverload(progressiveOverloadModel);
                changeScreen(context, ProgressiveOverload());
            }, 
            icon: Icon(Icons.done, color: globals.textColor2, size: 29,)),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: "Update your Exercise Performance",
                weight: FontWeight.bold,
                size: 23,
                color: globals.textPurple,
              ),
            ),
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
                        child: CustomText(text: "Number of sets" , color: globals.textPurple, weight: FontWeight.bold, size: 18,),
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
                        child: CustomText(text: "Number of reps", color: globals.textPurple, weight: FontWeight.bold, size: 18,),
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
                        child: CustomText(text: "Weight", color: globals.textPurple, weight: FontWeight.bold, size: 18,),
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
                              border:
                                  OutlineInputBorder(borderSide: BorderSide.none)),
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

  Future<void> updateProgressOverload(ProgressiveOverloadModel element) async{

      var client = http.Client();

      try{
        
        String api = globals.API_ardress;
        String id = element.id;

         var response = await http.put(Uri.parse("$api/api/v1/progressiveOverload/editProg/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "PUT, OPTIONS"
          },
          body: jsonEncode({
            "userId":element.userId,
            "exerciseId":element.exerciseId,
            "weight":element.weight,
            "reps":element.reps,
            "sets":element.sets
          }));

          if(response.statusCode == 200){
            print("PROG OVERLOAD EDITTED");
            await ProgressiveOverload_Manager().getPOVByUser();
          }
          else{
            print(response.body);
          }
        
      }catch(err){
        print(err);
      }

  }
}

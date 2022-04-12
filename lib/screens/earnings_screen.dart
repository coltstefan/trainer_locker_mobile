import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/globals.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/TrainingPlan.dart';

import '../services/trainer_manager.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({ Key key , this.trainingPlans}) : super(key: key);

  final List<TrainingPlan> trainingPlans;

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new , color: textColor2,),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: containerColor,
        title: CustomText(text: "${currTrainer.firstName}'s Earnings", color: textColor1, size: 21, weight: FontWeight.bold,),
      ),
      backgroundColor: containerColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Total Orders: ${Trainer_Manager().getTotalOrders(currTrainer)}" , color: textColor1, size: 21, weight: FontWeight.bold,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Total Earnings: ${Trainer_Manager().getTotalEarnings()} USD", color: textColor1, size: 21, weight: FontWeight.bold,),
            ),

            Trainer_Manager().getPopularTrainers().where((element) => element.id == currTrainer.id).isNotEmpty ?
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: CustomText(text: "Congratulations! You are one of our most popular trainers", color: textPurple, size: 21, weight: FontWeight.bold,),
             )
            : CustomText(text: "") ,

            Center(
              child: Container(
                height: 3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: textPurple,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: textColor2,
                      offset: Offset(3,2),
                      blurRadius: 4
                    )
                  ]
                ),
              ),
            ),
            SizedBox(height: 10,),

            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: widget.trainingPlans.map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: e.name , size: 18, weight: FontWeight.bold, color: textColor1,),
                                CustomText(text: "+ ${e.price} USD", color: textPurple, weight: FontWeight.bold, size: 18,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )).toList(),
                )
              ],
            )
          ],
        ),
      ),
      
    );
  }
}
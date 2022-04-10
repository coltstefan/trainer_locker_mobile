

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/screens/add_training_days.dart';
import 'package:mobile_final/screens/trainer_locker.dart';
import 'package:mobile_final/services/training_plan_manager.dart';

class AddTrainingPlan extends StatefulWidget {
  const AddTrainingPlan({ Key key }) : super(key: key);

  @override
  State<AddTrainingPlan> createState() => _AddTrainingPlanState();
}

class _AddTrainingPlanState extends State<AddTrainingPlan> {

  var nameController = TextEditingController();
  var durationController = TextEditingController();
  var priceController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: (){
            changeScreen(context, TrainerLocker());
          },

        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: CustomText(text: "Add New Training Plan", color: Colors.white, weight: FontWeight.bold, size: 19,),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.done))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Enter Training Plan Name" , weight: FontWeight.bold, color: Colors.white, size: 20,),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,0,0,0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText: "Enter Name",
                                    hintStyle: TextStyle(
                                      color: Colors.black26
                                    ),
                                    border: InputBorder.none
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width/6+10,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3,
                                          offset: Offset(2,1)
                                        )
                                      ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8,8,0,0),
                                      child: TextFormField(
                                                controller: durationController,
                                                decoration: InputDecoration(
                                                  hintText: "Duration",
                                                  hintStyle: TextStyle(
                                                    color: Colors.black26
                                                  ),
                                                  border: InputBorder.none
                                                ),
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.digitsOnly
                                                ],
                                                ),
                                    ),
                                    
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: CustomText(text: "minutes",weight: FontWeight.bold, size: 20, color: Colors.deepPurpleAccent,),
                                  )
                                ],
                              ),
                            ),
                           
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width/6,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3,
                                          offset: Offset(2,1)
                                        )
                                      ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8,8,0,0),
                                      child: TextFormField(
                                                controller: priceController,
                                                decoration: InputDecoration(
                                                  hintText: "Price",
                                                  hintStyle: TextStyle(
                                                    color: Colors.black26
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                ),
                                    ),
                                    
                                  ),
                                 Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: CustomText(text: "USD",weight: FontWeight.bold, size: 20, color: Colors.deepPurpleAccent,),
                                  )
                                ],
                              ),
                            ),
                  ],
                ),
              ),

              Center(
                child: GestureDetector(
                  onTap: (){
                    //globals.currentTrainingPn.name = nameController.text;
                    globals.currentTrainingPlan.name = nameController.text;
                    globals.currentTrainingPlan.duration = int.parse(durationController.text);
                    globals.currentTrainingPlan.price = double.parse(priceController.text);
                    TrainingPlan_Manager().createPlan(nameController.text,int.parse(durationController.text), double.parse(priceController.text),globals.currTrainer.id);
                    changeScreen(context, AddTrainingDays());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.66,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: CustomText(text: "Add Training Days",color: Colors.white, weight: FontWeight.bold, size: 20,)),
                  ),
                ),
              )

            ],
          ),
        ),
      ), 
    );
  }
}
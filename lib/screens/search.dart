import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/screens/searchByTrainer.dart';
import 'package:mobile_final/services/api_manager.dart';
import 'package:mobile_final/services/trainer_manager.dart';
import 'package:mobile_final/services/training_plan_manager.dart';
import 'package:mobile_final/widgets/bottomnavigation.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/widgets/searchResult.dart';

import '../models/Trainer.dart';
import '../models/TrainingPlan.dart';



class Search extends StatefulWidget {
  const Search({ Key key}) : super(key: key);

  

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var planCotroller = TextEditingController();
  List<TrainingPlan> foundTrainingPlans = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Trainers");
    print(globals.allTrainers.length);
   
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: CustomText(text: "",),
        centerTitle: true,
        title: CustomText(text: "Search by Training Plan", size: 20, color: Colors.black, weight: FontWeight.bold,),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBarFb1(),
      resizeToAvoidBottomInset: false ,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CustomText(text: "Switch Search", weight: FontWeight.bold,color: Colors.black54,),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                        //top: BorderSide(width: 1.0, color: Colors.black54),
                        right: BorderSide(width: 1.0, color: Colors.deepPurpleAccent.shade400),
                        bottom: BorderSide(width: 2.0, color: Colors.deepPurpleAccent.shade400),
                      ),
                      ),
                      child: Center(child: CustomText(text: "Training Plan",weight: FontWeight.bold,color: Colors.black54,)),
                    ),
                    GestureDetector(
                      onTap: (){
                        changeScreen(context, SearchByTrainer());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                          //top: BorderSide(width: 1.0, color: Colors.black54),
                          // right: BorderSide(width: 2.0, color: Colors.deepPurpleAccent.shade400),
                          // bottom: BorderSide(width: 2.0, color: Colors.deepPurpleAccent.shade400),
                        ),
                        ),
                        child: Center(child: CustomText(text: "Trainer",weight: FontWeight.bold, color: Colors.black54,)),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: planCotroller,
                    onChanged: (text){
                       setState(() {
                      foundTrainingPlans  = TrainingPlan_Manager().searchTrainingPlan(text);
                      print(foundTrainingPlans);
                      if(text == ""){
                        foundTrainingPlans = [];
                      }
                    });

                    },
                    decoration: 
                    InputDecoration(
                      hintText: 'Search Training Plan',
                      hintStyle: heading6.copyWith(color: textGrey),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),

                  ),
                )
                ),
                IconButton(
                  icon: Icon(Icons.search_outlined, color: Colors.deepPurpleAccent, size: 30,),
                  onPressed: ()async{
                   
                    setState(() {
                      foundTrainingPlans  = TrainingPlan_Manager().searchTrainingPlan(planCotroller.text);
                    });

                    },
                  ),

              ],
                ),

              ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: foundTrainingPlans.map((item) =>SearchResult(trainingPlan: item)).toList(),
                ),
                
              ],
            ),
          
             

          ],

        ),
      ),
      
    );
  }
}
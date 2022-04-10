import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/screens/search.dart';

import '../helpers/custom_text.dart';
import '../helpers/theme.dart';
import '../models/TrainingPlan.dart';
import '../services/training_plan_manager.dart';
import '../widgets/bottomnavigation.dart';
import '../widgets/searchResult.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;


class SearchByTrainer extends StatefulWidget {
  const SearchByTrainer({ Key key  , this.planController}) : super(key: key);

  final TextEditingController planController;

  @override
  State<SearchByTrainer> createState() => _SearchByTrainerState();
}

class _SearchByTrainerState extends State<SearchByTrainer> {
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: CustomText(text: "",),
        centerTitle: true,
        title: CustomText(text: "Search by Trainer", size: 20, color: Colors.black, weight: FontWeight.bold,),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBarFb1(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CustomText(text: "Switch Search", weight: FontWeight.bold,color: Colors.black54,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        changeScreen(context, Search());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                          //top: BorderSide(width: 1.0, color: Colors.black54),
                          // right: BorderSide(width: 1.0, color: Colors.deepPurpleAccent.shade400),
                          // bottom: BorderSide(width: 2.0, color: Colors.deepPurpleAccent.shade400),
                        ),
                        ),
                        child: Center(child: CustomText(text: "Training Plan",weight: FontWeight.bold,color: Colors.black54,)),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                          //top: BorderSide(width: 1.0, color: Colors.black54),
                          left: BorderSide(width: 2.0, color: Colors.deepPurpleAccent.shade400),
                          bottom: BorderSide(width: 2.0, color: Colors.deepPurpleAccent.shade400),
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
                      foundTrainingPlans  = TrainingPlan_Manager().searchTrainingPlanByTrainer(text);
                      if(text == ""){
                        foundTrainingPlans = [];
                      }
                    });

                    },
                    decoration: 
                    InputDecoration(
                      hintText: 'Search by Trainer',
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
                      foundTrainingPlans  = TrainingPlan_Manager().searchTrainingPlanByTrainer(planCotroller.text);
                      
                    });
                     

                    },
                  ),

              ],
                ),

              ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: foundTrainingPlans.map((item) => SearchResult(trainingPlan: item)).toList(),
                )
              ],
            ),
             

          ],

        ),
      ),
      
    );
  }
}
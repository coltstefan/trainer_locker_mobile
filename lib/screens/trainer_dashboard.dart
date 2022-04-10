import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/screens/trainer_locker.dart';
import 'package:mobile_final/services/api_manager.dart';
import 'package:mobile_final/widgets/bottomnavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:flutter/material.dart';

class TrainerDashboard extends StatefulWidget {
  @override
  _TrainerDashboardState createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarFb1(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CustomText(text: "Become a verified trainer " , size: 25, weight: FontWeight.bold,),
                    Icon(Icons.verified , color: Colors.deepPurpleAccent,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,0,8,8),
                child: Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              // FIRST TILE!
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [Container(
                        height: 80,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [

                                  Colors.deepPurple,
                                  Colors.deepPurpleAccent,
                                 // Colors.purple,
                                ]
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: CustomText(text: "Create workout routines from your phone", size: 17, weight: FontWeight.bold, color: textWhiteGrey,)),
                        ),
                      ),

                ]
                    )
                  ],
                ),
              ),
              //SECOND TILE
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Stack(
                        children: [Container(
                          height: 80,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [

                                    Colors.deepPurpleAccent,
                                    Colors.deepPurple,
                                    // Colors.purple,
                                  ]
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12,8,8,8),
                            child: Center(child: CustomText(text: "Build a community of people that trust you", size: 17, weight: FontWeight.bold, color: textWhiteGrey,)),
                          ),
                        ),

                        ]
                    )
                  ],
                ),
              ),
              //Third TILE
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                        children: [Container(
                          height: 80,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [

                                    Colors.deepPurpleAccent,
                                    Colors.deepPurple,
                                    // Colors.purple,
                                  ]
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: CustomText(text: "Sell your workout plans on our platfom", size: 17, weight: FontWeight.bold, color: textWhiteGrey,)),
                          ),
                        ),



                        ]
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [

                          Colors.deepPurpleAccent,
                          Colors.deepPurple,
                          // Colors.purple,
                        ]

                    ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurpleAccent,
                      blurRadius: 2,
                      offset: Offset(1,2)
                    )
                  ]
                ),
              ),


              SizedBox(
                height: 20,
              ),

              Center(
                child: Text(
                  "Activate your own Trainer Locker",
                  style: heading5,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(
                  child: GestureDetector(
                    onTap: (){
                      setTrainer();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [

                                  Colors.deepPurpleAccent,
                                  //Colors.purpleAccent,
                                  Colors.deepPurple,
                                  // Colors.purple,
                                ]

                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurpleAccent,
                                blurRadius: 1,
                                offset: Offset(1,1)
                              )
                            ]



                          ),
                          child: Center(child: CustomText(text: "Get Started", color: textWhiteGrey, weight: FontWeight.bold, size: 30,)),
                        ),



                      ],
                    ),
                  )
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Future<void> setTrainer() async{

    try{
      await API_Manager().modIsTrainer();
      changeScreenReplacement(context, TrainerLocker());
    }catch(Exception){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Blank Field not allowed")));
    }


  }
}

import 'dart:core';
import 'dart:core';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';

import 'login.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  List<CustomText> customTexts = [
    CustomText(text: "Create an account and complete your profile" , color: Colors.white, weight: FontWeight.bold, size: 25,),
    CustomText(text: "Search through the thousands of workout programmes" , color: Colors.white, weight: FontWeight.bold, size: 25,),
    CustomText(text: "Create daily goals and complete challanges" , color: Colors.white, weight: FontWeight.bold, size: 25,),
    CustomText(text: "Get the best recipes for some healthy meals" , color: Colors.white, weight: FontWeight.bold, size: 25,),
    CustomText(text: "Become a better version of youself" , color: Colors.white, weight: FontWeight.bold, size: 25,),
  ];

  List<String> workouts = ["https://www.sponser.com/media/catalog/product/h/e/header_pre_workout_booster.png", "https://www.runtastic.com/blog/wp-content/uploads/2018/08/thumbnail_1200x800-1-1024x683.jpg", "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/muscular-build-athlete-having-cross-training-in-a-royalty-free-image-1618930811.?resize=640:*"];

  List<String> trainers = ["https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/muscular-trainer-writing-on-clipboard-royalty-free-image-675179390-1562868231.jpg","https://media.istockphoto.com/photos/fitness-trainer-at-gym-picture-id1072395722?k=20&m=1072395722&s=612x612&w=0&h=zhxJbv4VDqOqt5JwXI7CgZ0CXfXtagmdtF2mSITW0eo=","https://media.istockphoto.com/photos/fitness-instructor-guiding-young-woman-when-she-exercises-picture-id1137413164?k=20&m=1137413164&s=612x612&w=0&h=p2XDvediJn2tdionq90PU6q58a7RsKdkZglW6jEb3_k="];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24,40,24,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurpleAccent,
                      offset: Offset(4,2),
                      blurRadius: 0

                    )

                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText(text: "Fitness" , color: Colors.black,size: 35, weight: FontWeight.bold,),
                      CustomText(text: "App" , color: Colors.deepPurpleAccent,size: 35, weight: FontWeight.bold,)
                    ],
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     Container(
              //       width: 100,
              //       height: 4,
              //       decoration: BoxDecoration(
              //           color: Colors.deepPurpleAccent,
              //           borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(14),
              //               bottomLeft: Radius.circular(14)
              //           )
              //
              //       ),
              //     ),
              //     Container(
              //       width: 55,
              //       height: 4,
              //       decoration: BoxDecoration(
              //           color: Colors.black,
              //           borderRadius: BorderRadius.only(
              //             topRight: Radius.circular(14),
              //             bottomRight: Radius.circular(14)
              //           )
              //
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),

              Container(
                height: 381,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(text: "BEST WORKOUTS" , weight: FontWeight.bold, size: 25, color: Colors.black,),
                      ),
                      Container(
                        height: 4,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ImageStack(
                                imageList: workouts,
                                totalCount: workouts.length,
                                imageBorderColor: Colors.white,
                                imageRadius: 100,
                                imageBorderWidth: 3,
                                imageCount: workouts.length,
                            ),

                            SizedBox(
                              width: 60,
                            ),

                            Container(
                              height: 50,
                              width: 4,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ],
                        ),

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(text: "BEST TRAINERS" , weight: FontWeight.bold, size: 25, color: Colors.black,),
                      ),
                      Container(
                        height: 4,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ImageStack(
                              imageList: trainers,
                              totalCount: trainers.length,
                              imageBorderColor: Colors.white,
                              imageRadius: 100,
                              imageBorderWidth: 3,
                              imageCount: trainers.length,
                            ),
                            SizedBox(
                              width: 60,
                            ),

                            Container(
                              height: 50,
                              width: 4,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ),
              SizedBox(height: 9,),

              //Center(child: CustomText(text: "Get to work!", size: 30, weight: FontWeight.bold,)),
              //SizedBox(height: 40,),

              InkWell(
                  onTap: (){
                    print("Hello");

                  },
                  child: Center(
                    child: Container(
                      height: 56,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(child: CustomText(text: "Sign Up", color: CupertinoColors.white, weight: FontWeight.bold, size: 20,)),
                    ),
                  )
              ),
                SizedBox(
                  height: 20,
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(57,0,8,8),
                child: Row(
                  children: [
                    CustomText(text: "Already have an account?  " ,weight: FontWeight.bold, size: 17,),
                    GestureDetector(
                        onTap: (){
                          changeScreen(context, Login());
                        },
                        child: CustomText(text: "Log in", color: Colors.deepPurple, weight: FontWeight.bold, size: 17,))
                  ],
                ),
              )

          ]
          ),
        ),
      ),
    );
  }
}

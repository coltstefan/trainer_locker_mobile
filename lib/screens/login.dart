import 'dart:convert';

import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/primary_button.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/User.dart';
import 'package:mobile_final/screens/dashboard.dart';
import 'package:mobile_final/screens/midscreen.dart';
import 'package:mobile_final/screens/register.dart';
import 'package:mobile_final/screens/start.dart';
import 'package:mobile_final/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/services/exercise_manager.dart';

import '../services/trainer_manager.dart';
import '../services/training_plan_manager.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {




  var userController = TextEditingController();
  var passController = TextEditingController();

  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24,40,24,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Login into your\naccount',
                        style: heading2.copyWith(color: Colors.black),
                      ),
                      IconButton(icon: Icon(Icons.arrow_back_outlined, color: Colors.deepPurpleAccent,), onPressed: (){
                        changeScreen(context, Start());
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10)

                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ) , 
                  
                  Form(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: textWhiteGrey,
                              borderRadius: BorderRadius.circular(14)
                            ),
                            child: TextFormField(
                              controller: userController,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                hintStyle: heading6.copyWith(color: textGrey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                )
                              ),
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
                              controller: passController,
                              obscureText: !passwordVisible,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: heading6.copyWith(color: textGrey),
                                suffixIcon: IconButton(
                                  color: textGrey,
                                  splashRadius: 1,
                                  icon: Icon(passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                  onPressed: togglePassword,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                                )
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 32,
                  ),

                  InkWell(
                    onTap: (){
                      print("Hello");
                      login();
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(child: CustomText(text: "Login", color: CupertinoColors.white, weight: FontWeight.bold, size: 20,)),
                    )
                  ),

                  SizedBox(
                    height: 24,
                  ),

                  InkWell(
                    onTap: (){
                      changeScreen(context, Register());
                    },
                    child: Container(
                      child: Center(
                        child: CustomText(text: "Don't have an account? Register here", color: Colors.deepPurpleAccent,weight: FontWeight.bold , size: 15,),
                      ),
                    ),

                  )

                ],
              )
            ],
          ),
        ),
      ),




    );
  }

   Future<void> login() async {
     String api = globals.API_ardress;
    if(passController.text.isNotEmpty && userController.text.isNotEmpty){
      var response = await http.post(Uri.parse("$api/api/v1/users/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
            //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: jsonEncode({
        'username': userController.text,
        'password': passController.text
      }));

      //print(response.statusCode);

      if(response.statusCode == 200){
        Users currUser = await API_Manager().getUser(userController.text);
        // print("Aici");
        // print(currUser.username);
        globals.currUser = currUser;
        globals.isLoggedIn = true;
        if(globals.currUser.isTrainer == true){
          await API_Manager().userIsTrainer(currUser.username);
          //await Future.delayed(const Duration(seconds: 2) , (){});
        }
        changeScreenReplacement(context, Midscreen());
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid credentials")));
        print(userController.text);
        print(passController.text);
        print(response.statusCode);
        print(response.body);
      }
    } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Blank Field not allowed")));
    }




   }
}

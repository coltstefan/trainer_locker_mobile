import 'dart:convert';

import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/primary_button.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/User.dart';
import 'package:mobile_final/screens/dashboard.dart';
import 'package:mobile_final/screens/login.dart';
import 'package:mobile_final/screens/start.dart';
import 'package:mobile_final/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_final/helpers/globals.dart' as globals;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  var userController = TextEditingController();
  var passController = TextEditingController();
  var emailController = TextEditingController();
  var lastNameController = TextEditingController();
  var firstNameController = TextEditingController();

  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: 
        Padding(
          padding: const EdgeInsets.fromLTRB(24,40,24,0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Create a new\naccount',
                style: heading2.copyWith(color: Colors.black),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_outlined , color: Colors.deepPurpleAccent))
          ]),
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
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
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
                  Container(
                            decoration: BoxDecoration(
                              color: textWhiteGrey,
                              borderRadius: BorderRadius.circular(14)
                            ),
                            child: TextFormField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                hintText: 'First Name',
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
                              borderRadius: BorderRadius.circular(14)
                            ),
                            child: TextFormField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                hintText: 'Last Name (Family Name)',
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
                          

                  InkWell(
                    onTap: (){
                      print("Hello");
                      register();
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(child: CustomText(text: "Register", color: CupertinoColors.white, weight: FontWeight.bold, size: 20,)),
                    )
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  InkWell(
                    onTap: (){
                      changeScreen(context, Login());
                    },
                    child: Container(
                      child: Center(
                        child: CustomText(text: "Already have an account? Login here", color: Colors.deepPurpleAccent,weight: FontWeight.bold , size: 15,),
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 250,
                  ),

          ],
        ),
      ),
      )
    );
  }

  Future<void> register() async {
    if(passController.text.isNotEmpty && userController.text.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)){
      var response = await http.post(Uri.parse("http://10.0.2.2:8080/api/v1/users/register"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
            //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: jsonEncode({
        'username': userController.text,
        'email': emailController.text,
        'password': passController.text,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text

      }));

      //print(response.statusCode);

      if(response.statusCode == 200){
        Users currUser = await API_Manager().getUser(userController.text);
        print("Aici");
        print(currUser.username);
        globals.currUser = currUser;
        globals.isLoggedIn = true;
        changeScreenReplacement(context, Dashboard());
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


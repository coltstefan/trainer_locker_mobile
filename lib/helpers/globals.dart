import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_final/models/ProgressiveOverload.dart';
import 'package:mobile_final/models/Trainer.dart';
import 'package:mobile_final/models/TrainingDay.dart';
import 'package:mobile_final/models/User.dart';
import 'package:mobile_final/models/TrainingPlan.dart';
import 'package:mobile_final/models/Exercise.dart';
import 'package:mobile_final/models/ExerciseSet.dart';

import '../models/Payment.dart';


bool isLoggedIn;
Users currUser;
Trainer currTrainer;
List<TrainingPlan> trainingPlansCurrTrainer = [];
List<TrainingPlan> trainingPlansCurrUser = [];
List<Exercise> exercises = [];
List<ExerciseSet> exerciseSets = [];
TrainingPlan currentTrainingPlan = TrainingPlan();
TrainingDay currentTrainingDay = TrainingDay();
List<TrainingDay> currentTrainingDays = [];
List<Exercise> currExercises = [];
List<ExerciseSet> currExerciseSets = [];
List<TrainingPlan> allTrainingPlans = [];
List<Trainer> allTrainers = [];
List<ProgressiveOverloadModel> allProgressiveOverloads = [];
List<Payment> currTrainerPayments = [];

Color containerColor = Colors.white;
Color backgroundColor = Colors.white;
Color textColor1 = Colors.black;
Color textColor2 = Colors.black54;
Color textColorIcons = Colors.grey;
Color textPurple = Colors.deepPurpleAccent;
bool darkMode = false;
var planController = TextEditingController();


//String API_ardress = "https://c9b7-2a04-2419-8b06-bc00-c571-13a9-9479-e4f9.eu.ngrok.io";
String API_ardress = "http://10.0.2.2:8080";
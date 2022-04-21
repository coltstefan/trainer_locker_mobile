import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/models/ProgressiveOverload.dart';
import 'package:mobile_final/screens/progressive_overload.dart';


class ProgressiveOverload_Manager{


    Future<void> getPOVByUser() async{

        var client = http.Client();
        globals.allProgressiveOverloads = [];

        try{

          String api = globals.API_ardress;
          String id = globals.currUser.id;

          var response = await client.get(Uri.parse("$api/api/v1/progressiveOverload/findByUserId/$id"));

          if(response.statusCode == 200){
            var jsonString = response.body;
            var prog_overloads = jsonDecode(jsonString);

            for(var prog_overload in prog_overloads){
                
                ProgressiveOverloadModel progressiveOverload = ProgressiveOverloadModel(
                  id: prog_overload['id'],
                  userId: prog_overload['userId'],
                  exerciseId: prog_overload['exerciseId'],
                  weight: prog_overload['weight'],
                  reps: prog_overload['reps'],
                  sets: prog_overload['sets'],
                );

                globals.allProgressiveOverloads.add(progressiveOverload);

            }

          }
          
        }catch(err){

        }

    }


}
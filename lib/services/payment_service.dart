import 'dart:convert';

import 'package:mobile_final/models/Payment.dart';

import '../helpers/globals.dart' as globals;
import 'package:http/http.dart' as http;

class PaymentManager{

  Future<List<Payment>> getPaymentsByCurrTrainer() async{

    var client = http.Client();
    globals.currTrainerPayments = [];

    try{

      String api = globals.API_ardress;
      String id = globals.currTrainer.id;

      var response = await http.get(Uri.parse("$api/api/v1/payment/findByTrainerId/$id"));
      print(response);
      if(response.statusCode == 200){
        var jsonString = response.body;
        var payments = jsonDecode(jsonString);
        print(payments);

        for(var payment in payments){

          Payment payment1 = Payment(
            id: payment['id'],
            userId: payment['userId'],
            trainerId: payment['trainerId'],
            trainingPlanId: payment['trainingPlanId'],
            payment: payment['payment'],
            yearCreated: payment['yearCreated'],
            monthCreated: payment['monthCreated'],
            dayCreated: payment['dayCreated'],
          );

          globals.currTrainerPayments.add(payment1);

        }

      }
      else{
        print(response.body);
      }

    }catch(err){
      print("GET ALL PAYMENTS");
      print(err);
    }

  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/helpers/theme.dart';
import 'package:mobile_final/models/Payment.dart';
import 'package:mobile_final/models/TrainingPlan.dart';
import 'package:mobile_final/services/training_plan_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../services/trainer_manager.dart';


class EarningsScreen extends StatefulWidget {
  const EarningsScreen({ Key key , this.trainingPlans}) : super(key: key);

  final List<TrainingPlan> trainingPlans;

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {

  List<SalesData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getSalesData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new , color: globals.textColor2,),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: globals.containerColor,
        title: CustomText(text: "${globals.currTrainer.firstName}'s Earnings", color: globals.textColor1, size: 21, weight: FontWeight.bold,),
      ),
      backgroundColor: globals.containerColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Total Orders: ${Trainer_Manager().getTotalOrders(globals.currTrainer)}" , color: globals.textColor1, size: 21, weight: FontWeight.bold,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Total Earnings: ${Trainer_Manager().getTotalEarnings()} USD", color: globals.textColor1, size: 21, weight: FontWeight.bold,),
            ),

            Trainer_Manager().getPopularTrainers().where((element) => element.id == globals.currTrainer.id).isNotEmpty ?
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: CustomText(text: "Congratulations! You are one of our most popular trainers", color: globals.textPurple, size: 21, weight: FontWeight.bold,),
             )
            : CustomText(text: "") ,

            Center(
              child: Container(
                height: 3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: globals.textPurple,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: globals.textColor2,
                      offset: Offset(3,2),
                      blurRadius: 4
                    )
                  ]
                ),
              ),
            ),
            SizedBox(height: 10,),


            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  LineSeries<SalesData,int>(
                    dataSource: _chartData,
                    color: globals.textPurple,
                   xValueMapper: (SalesData sales,_) => sales.day, 
                   yValueMapper: (SalesData sales,_) => sales.sales,
                   dataLabelSettings: DataLabelSettings(isVisible: true,labelAlignment: ChartDataLabelAlignment.top, useSeriesColor: true , showZeroValue: false ),
                   markerSettings: MarkerSettings(isVisible: true)),
                ],
                primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift , borderColor: globals.textPurple),
                primaryYAxis: NumericAxis(numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
              ),
            ),

            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: globals.currTrainerPayments.map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 75,
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: TrainingPlan_Manager().getTrainingPlanByIdLOCAL(e.trainingPlanId).name, size: 17, weight: FontWeight.bold, color: globals.textColor1,),
                                CustomText(text: "+ ${e.payment} USD", color: globals.textPurple, weight: FontWeight.bold, size: 17,)
                              ],
                            ),
                          ),

                          

                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,0,8,0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.payment ,color: globals.textColor2,),
                                SizedBox(width: 10,),
                                CustomText(text: "${e.dayCreated} ${e.monthCreated.toLowerCase()} ${e.yearCreated}", size: 16, weight: FontWeight.bold, color: globals.textColor2,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )).toList(),
                )
              ],
            )
          ],
        ),
      ),
      
    );
  }

  List<SalesData> getSalesData(){

    DateTime now = new DateTime.now();
    
    DateTime date = new DateTime(now.year, now.month, now.day);

    List<DateTime> listDates = [ 
    date.subtract(const Duration(days: 3)),
    date.subtract(const Duration(days: 2)),
    date.subtract(const Duration(days: 1)),
    date,
    date.add(const Duration(days: 1)),
    date.add(const Duration(days: 2)),
    date.add(const Duration(days: 3)),
    ];

    List<double> listSales = [];

    for(DateTime date in listDates){
      double sales = 0;
      for(Payment payment in globals.currTrainerPayments){
        if(date.day == payment.dayCreated){
          sales = sales+payment.payment;
        }
      }

      listSales.add(sales);

    }

    final List<SalesData> chartData = [
      SalesData(listDates[0].day, listSales[0]),
      SalesData(listDates[1].day, listSales[1]),
      SalesData(listDates[2].day, listSales[2]),
      SalesData(listDates[3].day, listSales[3]),
      SalesData(listDates[4].day, listSales[4]),
      SalesData(listDates[5].day, listSales[5]),
      SalesData(listDates[6].day, listSales[6]),
    ];

    return chartData;
    

  }


  

}

class SalesData{

  SalesData(this.day,this.sales);
  final int day;
  final double sales;

}
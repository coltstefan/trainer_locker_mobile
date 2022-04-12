import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/globals.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/models/Comment.dart';
import 'package:mobile_final/models/Trainer.dart';
import 'package:mobile_final/screens/search.dart';
import 'package:mobile_final/services/comment_manager.dart';
import 'package:mobile_final/services/trainer_manager.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/services/training_plan_manager.dart';

import '../models/TrainingPlan.dart';

class TrainingPlanLP extends StatefulWidget {
  const TrainingPlanLP({Key key, this.trainingPlan, this.commentsList})
      : super(key: key);

  final TrainingPlan trainingPlan;
  final List<Comment> commentsList;

  @override
  State<TrainingPlanLP> createState() => _TrainingPlanLPState();
}

class _TrainingPlanLPState extends State<TrainingPlanLP> {
  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();
    bool posted = false;

    //List<Comment> comments_on_page = widget.commentsList.sublist(index,index+2);

    String textButton = "POST COMMENT";
    Trainer trainer =
        Trainer_Manager().getByIdLocal(widget.trainingPlan.trainerId);
    String buttonText = "Buy Now";
    Color buttonColor = Colors.deepPurpleAccent;
    int orders = widget.trainingPlan.userIds.length;
    bool alreadyOwned =
        globals.currUser.trainingPlanIds.contains(widget.trainingPlan.id);
    bool toggleComment = false;
    if (alreadyOwned) {
      setState(() {
        buttonColor = Colors.green;
        buttonText = "Owned";
      });
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: commentController,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: "Write your opinion",
                            focusColor: textPurple),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () async {
                              String text = commentController.text;
                              commentController.text = "POSTING COMMENT , PLEASE WAIT!";
                              Comment comment = await Comments_Manager()
                                  .createComment(text,
                                      widget.trainingPlan.id);
                              await Future.delayed(const Duration(seconds: 2));
                              setState(() {
                                widget.commentsList.insert(0, comment);
                              });
                              Navigator.pop(context);
                            },
                            child: containerButton(110, 60, textButton)),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.33,
          height: 50,
          decoration: BoxDecoration(
              color: textPurple, borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              CustomText(
                text: "Add\nComment",
                color: Colors.white,
                weight: FontWeight.bold,
              ),
            ],
          )),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Container(
                      constraints: BoxConstraints(maxHeight: 100),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CustomText(
                        text: widget.trainingPlan.name,
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 16, 8, 0),
                  child: CustomText(
                    text: "by ${trainer.firstName} ${trainer.lastName}",
                    weight: FontWeight.bold,
                    size: 17,
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 2,
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(20)),
                    child: CustomText(
                      text: "",
                    ),
                  ),
                ),
                CustomText(
                  text:
                      "${widget.trainingPlan.trainingDaysList.length} Training Days",
                  size: 19,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text:
                            "Duration:  ${widget.trainingPlan.duration} Minutes",
                        size: 19,
                        color: Colors.black,
                        weight: FontWeight.bold,
                      ),
                      CustomText(
                        text: "${orders} Orders",
                        size: 19,
                        color: Colors.black,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Price:  ${widget.trainingPlan.price} USD",
                        size: 19,
                        color: Colors.black,
                        weight: FontWeight.bold,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.deferToChild,
                        onTap: () async {
                          await TrainingPlan_Manager()
                              .buyTrainingPlan(widget.trainingPlan.id);
                          setState(() {
                            print(globals.currUser.trainingPlanIds);
                            print(widget.trainingPlan.id);
                            orders++;
                          });
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            height: 30,
                            decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: CustomText(
                              text: buttonText,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ))),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "${widget.commentsList.length} Comments",
                      color: textColor2,
                      weight: FontWeight.bold,
                      size: 19,
                    ),
                    // GestureDetector(
                    //   //behavior: HitTestBehavior.translucent,
                    //   onTap: (){
                    //     setState(() {
                    //       if(toggleComment == false){
                    //         toggleComment = true;
                    //       }
                    //       else{
                    //         toggleComment = false;
                    //       }
                    //       print("PRESSED");
                    //       print(toggleComment);
                    //     });
                    //   },
                    //   child:containerButton( MediaQuery.of(context).size.width*0.33 , 40 , "Add Comment"))
                  ],
                ),
                Container(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.commentsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.account_circle_outlined,
                                          color: textColor2,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        CustomText(
                                          text:
                                              "${widget.commentsList[index].firstName} ${widget.commentsList[index].lastName}",
                                          size: 17,
                                          weight: FontWeight.bold,
                                          color: textColor2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text:
                                              "${widget.commentsList[index].dayCreated} ${widget.commentsList[index].monthCreated.toLowerCase()} ${widget.commentsList[index].yearCreated}",
                                          size: 17,
                                          weight: FontWeight.bold,
                                          color: textColor2,
                                        ),
                                        Icon(
                                          Icons.timelapse,
                                          color: textColor2,
                                          size: 16,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(text: "\"${widget.commentsList[index].comment}\"" , weight: FontWeight.bold, size: 17, color: textColor2,),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container containerButton(double width, double heigth, String text) {
    return Container(
      width: width,
      height: heigth,
      decoration: BoxDecoration(
          color: textPurple, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(11, 0, 0, 0),
        child: Center(
            child: CustomText(
          text: text,
          color: Colors.white,
          size: 17,
          weight: FontWeight.bold,
        )),
      ),
    );
  }

  Container commentField(TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: "Write your opinion", focusColor: textPurple),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: containerButton(110, 60, "POST COMMENT"),
            )
          ],
        ),
      ),
    );
  }
}

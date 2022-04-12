import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/widgets/bottomnavigation.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color buttonColor =
      globals.containerColor == Colors.white ? Colors.red : Colors.green;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarFb1(),
      backgroundColor: globals.containerColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Settings",
                color: globals.textColor1,
                weight: FontWeight.bold,
                size: 20,
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.person, size: 50,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "${globals.currUser.firstName} ${globals.currUser.lastName}" , size: 23, color: globals.textColor2, weight: FontWeight.bold,)
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (globals.textColor1 == Colors.black) {
                        globals.textColor1 = Colors.white;
                        globals.textColor2 = Colors.white;
                        globals.containerColor = Colors.black;
                        globals.textColorIcons = Colors.white;
                      } else {
                        globals.containerColor = Colors.white;
                        globals.textColor1 = Colors.black;
                        globals.textColor2 = Colors.black54;
                        globals.textColorIcons = Colors.grey;
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: globals.containerColor,
                        border: Border(
                            top: BorderSide(
                                width: 1.0, color: globals.textColor1),
                            bottom: BorderSide(
                                width: 1.0, color: globals.textColor1))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "DARK MODE",
                            color: globals.textColor1,
                            weight: FontWeight.bold,
                          ),
                          Switch(
                              value: globals.darkMode,
                              activeColor: Colors.deepPurpleAccent,
                              onChanged: (val) {
                                setState(() {
                                  if (globals.darkMode == false) {
                                    globals.darkMode = true;
                                    globals.textColor1 = Colors.white;
                                    globals.textColor2 = Colors.white;
                                    globals.containerColor = Colors.black;
                                    globals.backgroundColor = Colors.black;
                                    globals.textColorIcons = Colors.white;
                                    globals.textPurple = Colors.white;
                                  } else {
                                    globals.darkMode = false;
                                    globals.containerColor = Colors.white;
                                    globals.backgroundColor = Colors.white;
                                    globals.textColor1 = Colors.black;
                                    globals.textColor2 = Colors.black54;
                                    globals.textColorIcons = Colors.grey;
                                    globals.textPurple = Colors.deepPurpleAccent;
                                  }
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

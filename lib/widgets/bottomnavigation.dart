
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/screens/dashboard.dart';
import 'package:mobile_final/screens/progressive_overload.dart';
import 'package:mobile_final/screens/search.dart';
import 'package:mobile_final/screens/settings.dart';
import 'package:mobile_final/screens/trainer_dashboard.dart';
import 'package:mobile_final/screens/trainer_locker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/helpers/globals.dart' as globals;
import 'package:mobile_final/services/prog_overload_manager.dart';

import '../services/api_manager.dart';

class BottomNavBarFb1 extends StatelessWidget {
  const BottomNavBarFb1({Key key}) : super(key: key);

  final primaryColor = Colors.deepPurpleAccent;
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: globals.containerColor,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                  text: "",
                  icon: Icons.fitness_center,
                  selected: false,
                  onPressed: () async{
                    await ProgressiveOverload_Manager().getPOVByUser();
                    changeScreen(context, ProgressiveOverload());
                  }),
              IconBottomBar(
                  text: "Search",
                  icon: Icons.search_outlined,
                  selected: false,
                  onPressed: () {
                    changeScreen(context, Search());
                  }),
              IconBottomBar2(
                  text: "Home",
                  icon: Icons.home,
                  selected: true,
                  onPressed: () {
                    changeScreen(context, Dashboard());
                  }),
              IconBottomBar(
                  text: "Cart",
                  icon: Icons.verified,
                  selected: false,
                  onPressed: () {
                    if(globals.currUser.isTrainer == true){
                        changeScreen(context, TrainerLocker());
                    }
                    else{
                      changeScreen(context, TrainerDashboard());
                    }
                  }),
              IconBottomBar(
                  text: "Calendar",
                  icon: Icons.settings,
                  selected: false,
                  onPressed: () {
                    changeScreen(context, Settings());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key key,
         this.text,
         this.icon,
         this.selected,
         this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = const Color(0xff4338CA);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? primaryColor : globals.textColor2,
          ),
        ),
      ],
    );
  }
}

class IconBottomBar2 extends StatelessWidget {
  const IconBottomBar2(
      {Key key,
         this.text,
         this.icon,
         this.selected,
         this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final primaryColor = const Color(0xff4338CA);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: primaryColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlassCardFb1 extends StatelessWidget {
  final String text;
  final String subtitle;
  const GlassCardFb1({ this.text,  this.subtitle, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          width: 150.0,
          height: 100.0,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: .25),
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.grey.shade200.withOpacity(0.15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Text(subtitle,
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}
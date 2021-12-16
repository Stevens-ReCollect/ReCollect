
import 'package:flutter/material.dart';
import 'package:recollect_app/settings.dart';

class TextSizeConstants {
 static const double h1 = 64;
 static const double h2 = 30; 
 static const double formField = 18;
 static const double buttonText = 24;
 static const double memoryTitle = 30; 
 static const double tag = 18;
 static const double bodyText = 24;
 static const double dropDownText = 18;


  static getadaptiveTextSize(BuildContext context, double value) {
    return (value / 720) * TextAdjustPageState.textAdjust * MediaQuery.of(context).size.height;
 }

}

  

  
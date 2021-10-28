
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class ColorConstants {
  static var isCaregiver;
  static var buttonColor; //Trying to toggle colors
  static Color formField = Color(0xFFE0E0E0);
  static const Color bodyText = Colors.black;
  static Color hintText = Color(0xFF8F8F8F);
  static Color buttonText = Colors.white;
  static var appBar; //Trying to toggle colors
  static Color unfavoredButton = Color(0x8C303000);
  
  setCaregiverColors(){
    if (isCaregiver == true){
      appBar = Color(0xFF00CB5D);
      buttonColor = Color(0xFF308C39);
    } else if (isCaregiver == false){
      appBar = Color(0xFF30658C);
      buttonColor = Color(0xFF30658C);
    }
  }
  
  } 

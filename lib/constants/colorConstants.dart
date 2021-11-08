import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorConstants {
 
  static var buttonColor = Color(0xFF308C39); //Trying to toggle colors
  static Color formField = Color(0xFFE0E0E0);
  static const Color bodyText = Colors.black;
  static Color hintText = Color(0xFF8F8F8F);
  static Color buttonText = Colors.white;
  static var appBar = Color(0xFF00CB5D); //Trying to toggle colors
  static Color unfavoredButton = Color(0x8C303000);

 static toggleColors(int value){
  if (value == 0) { //Attempt at toggle
            ColorConstants.appBar = Color(0xFF00CB5D);
            ColorConstants.buttonColor = Color(0xFF308C39);
            }  
      if (value == 1) {
              ColorConstants.appBar = Color(0xFF3065FC);
              ColorConstants.buttonColor = Color(0xFF30658C);
            }
}
}

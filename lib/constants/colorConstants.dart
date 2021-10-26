
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorConstants {
  static bool isCaregiver = true;
  static Color buttonColor = isCaregiver ? Color(0xFF308C39) : Color(0xFF30658C); 
  static Color formField = Color(0xFFE0E0E0);
  static const Color bodyText = Colors.black;
  static Color hintText = Color(0xFF8F8F8F);
  static Color buttonText = Colors.white;
  static Color appBar = isCaregiver ? Color(0xFF00CB5D) : Color(0xFF5498FF);
  static Color unfavoredButton = Color(0x8C303000);

  } 

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleWidget extends StatefulWidget {

 @override
  State<ToggleWidget> createState() => ToggleWidgetState();
}
class ToggleWidgetState extends State<ToggleWidget> {

createNewMemory(int value){
  if(value == 0){
  return ElevatedButton(onPressed:() {}, 
  style: ElevatedButton.styleFrom(primary: ColorConstants.buttonColor,
                    textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.buttonText)
  ),
  child: Text('Create New Memory'));
  } else {
    return SizedBox();
  }
}

@override
  Widget build(BuildContext context) {
  
  return Listener(
    // onPointerDown: ColorConstants().toggleColors(value),
    child: ToggleSwitch(
          minWidth: 95,
          inactiveBgColor: Colors.white,
          inactiveFgColor: ColorConstants.bodyText,
          activeBgColor: [ColorConstants.buttonColor],
          activeFgColor: ColorConstants.buttonText,
          initialLabelIndex: 0,
          totalSwitches: 2,
          labels: ['Edit Mode', 'Story Mode'],
          onToggle: (value) {   
             setState(() {
               ColorConstants.toggleColors(value);
               createNewMemory(value);
             });
  
          },         
        
  ));

  }

 
}
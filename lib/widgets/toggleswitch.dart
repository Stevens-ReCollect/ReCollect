import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleWidget extends StatelessWidget {
@override
  Widget build(BuildContext context) {
  
  return ToggleSwitch(
                minWidth: 95,
                inactiveBgColor: Colors.white,
                activeBgColor: [ColorConstants.buttonColor],
          initialLabelIndex: 0,
          totalSwitches: 2,
          labels: ['Edit Mode', 'Story Mode'],
          onToggle: (index) {
            
            print('switched to: $index');
            // ColorConstants().toggleColors(index);
            print(index);
            if (index == 0) { //Attempt at toggle
            ColorConstants.appBar = Color(0xFF00CB5D);
            ColorConstants.buttonColor = Color(0xFF308C39);
            }  else {
              ColorConstants.appBar = Color(0xFF3065FC);
              ColorConstants.buttonColor = Color(0xFF30658C);
            }
          },
              
        );

  }
}
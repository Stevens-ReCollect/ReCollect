
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:overlay_container/overlay_container.dart';
// import 'package:recollect_app/constants/colorConstants.dart';

// class EnterPin extends StatefulWidget{
//   @override 
//   State<EnterPin> createState() => EnterPinState(); 
// }


// class EnterPinState extends State<EnterPin> {
//   bool _dropdownShown = false;

//   void _toggleModes() {
//     setState(() {
//       _dropdownShown = !_dropdownShown;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return OverlayContainer(
//               show: _dropdownShown,
//               // Let's position this overlay to the right of the button.
//               position: OverlayContainerPosition(
//                 // Left position.
//                 150,
//                 // Bottom position.
//                 45,
//               ),
//               // The content inside the overlay.
//               child: Container(
//                 height: 70,
//                 padding: const EdgeInsets.all(20),
//                 margin: const EdgeInsets.only(top: 5),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 3,
//                       spreadRadius: 6,
//                     )
//                   ],
//                 ),
//                 child: Column(
//                 children: <Widget> [
//                   Text("Enter pin to continue to Edit Mode"),
//                   TextFormField(
//                     obscureText: true,
//                   ),
//                   ElevatedButton(onPressed: (){

//                   }, 
//                   child: Text('Continue'))
//                 ]
//                 )
//               ));
    
//   }
  
// }
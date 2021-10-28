import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/widgets/enterCaregiverPin.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReCollect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Welcome'),
    );
  }
}

class MyHomePage extends StatefulWidget {
 
  const MyHomePage({Key? key, required this.title}) : super(key: key);
 
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var accountMode = "Edit Mode"; //variable for Account Mode

  @override
  void initState() {
    ColorConstants().setCaregiverColors();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // App bar properties
        // title: Text(widget.title),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leadingWidth: 300,
        backgroundColor: ColorConstants.appBar,
        actions: <Widget>[
          Row(
            children: <Widget> [
              ToggleSwitch(
                minWidth: 100,
                inactiveBgColor: Colors.white,
                activeBgColor: [ColorConstants.buttonColor],
          initialLabelIndex: 0,
          totalSwitches: 2,
          labels: ['Edit Mode', 'Story Mode'],
          onToggle: (index) {
            print('switched to: $index');
            // ColorConstants.isCaregiver = !ColorConstants.isCaregiver;
            if (index == 0) { //Attempt at toggle
             ColorConstants.isCaregiver = true;
             EnterPin();
            } else if (index == 1){
              ColorConstants.isCaregiver = false;
                }
              },
              
        ),
        IconButton(
                icon: Icon(Icons.settings),  //Settings Icon 
                onPressed: () {  },
                ),
        ],),
        ]
      ),
      body: SingleChildScrollView(
        child: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
            padding: EdgeInsets.all(20),
            child: const Text(
              'New Memories', style: TextStyle(color: ColorConstants.bodyText, fontSize: TextSizeConstants.h2),
            )),
           Stack(
             alignment: Alignment.center,
               children: <Widget>[
                 Container(
                   width: 340,
                   height: 250,
                decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: new DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topLeft, 
                image: AssetImage('lib/images/wedding-placeholder.jpg'), 
                ))),
                Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(color: Colors.black26, 
                borderRadius: BorderRadius.all(Radius.circular(20)),),
                width: 340,
                height: 250,
                padding: EdgeInsets.only(left: 20, bottom: 10),
                 child: Text('Wedding', 
                 style: TextStyle(color: ColorConstants.buttonText, 
                  fontSize: TextSizeConstants.buttonText, 
                  fontWeight: FontWeight.w900), textAlign: TextAlign.left,),
                )
               ],
             ) 
  
          ],
        ),
    )));
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/memory_example.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:toggle_switch/toggle_switch.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReCollect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
      RouteConstants.homeRoute: (context) => MyHomePage(),
      RouteConstants.memoryRoute: (context) => MemoryPage(),
      RouteConstants.progressRoute: (context) => ProgressReport(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => MyHomePageState();
}
 
class MyHomePageState extends State<MyHomePage> {
static late int accountMode = 0;

createSettings(){ 
if(accountMode == 0){//settings on toggle
 return IconButton(
                icon: Icon(Icons.settings),  //Settings Icon 
                onPressed: () {  
                  Navigator.pushNamed(context, RouteConstants.progressRoute);
                },
                );
  } 
  if(accountMode == 1){
  return SizedBox();
}

}

createNewMemory(){ //Create New Memory button toggle

    if(accountMode == 0){
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child:ElevatedButton(onPressed:() {}, 
    style: ElevatedButton.styleFrom(primary: ColorConstants.buttonColor,
                      textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.buttonText)
    ),
    child: Text('Create New Memory')));
    } 
    if(accountMode == 1) {
      return SizedBox();
    } 
   
}

 static caregiverPin(BuildContext context){ //Caregiver Pin pop up
    return new AlertDialog(
    title: const Text('Enter Caregiver Pin before entering Edit Mode.'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter pin',
                  hintText: '####',
                ),
              ),
      ],
    ),
    actions: <Widget>[
      new ElevatedButton(
        style: ElevatedButton.styleFrom(primary: ColorConstants.buttonColor),
        onPressed: () {
          accountMode = 0;
          
          Navigator.of(context).pop();
        },
        child: const Text('Continue'),
      ),
    ],
  );
 }

 
  @override
  void initState() {
    ColorConstants.toggleColors(accountMode);
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
  MediaQueryData queryData = MediaQuery.of(context);
  var deviceWidth = queryData.size.width;
  var deviceHeight = queryData.size.height;
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
         Listener(
    // onPointerDown: ColorConstants().toggleColors(value),
    child: ToggleSwitch( //Toggle between modes
          minWidth: 95,
          inactiveBgColor: Colors.white,
          activeBgColor: [ColorConstants.buttonColor],
          initialLabelIndex: 0,
          totalSwitches: 2,
          labels: ['Edit Mode', 'Story Mode'],
          onToggle: (value) {   
             setState(() {
               print('switched to: $value');
               ColorConstants.toggleColors(value);
               accountMode = value;
               if (accountMode == 0) {
                 showDialog(
              context: context,
              builder: (BuildContext context) => caregiverPin(context),
                 );}
             });
  
          },         
        
  )),
      //   SizedBox(
      //    width: 0.38*deviceWidth,
      //  ),
        createSettings(),
        ],),
        ]
      ),
      body: SingleChildScrollView(
        child: AspectRatio(
        aspectRatio: 100 / 100,
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
            createNewMemory(),
            InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.memoryRoute);
            }, 
           child: Stack(
             alignment: Alignment.center,
               children: <Widget>[
                 Container(
                   width: 0.8*deviceWidth,
                   height: deviceHeight / 4,
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
                width: 0.8*deviceWidth,
                height: deviceHeight / 4,
                padding: EdgeInsets.only(left: 20, bottom: 10),
                 child: Text('Wedding', 
                 style: TextStyle(color: ColorConstants.buttonText, 
                  fontSize: TextSizeConstants.buttonText, 
                  fontWeight: FontWeight.w900), textAlign: TextAlign.left,),
                )
               ],
             ) 
            )
  
          ],
        ),
    ))));
  }
}

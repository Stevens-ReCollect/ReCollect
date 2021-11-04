import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/memory.dart';
import 'package:recollect_app/widgets/enterCaregiverPin.dart';
import 'package:recollect_app/widgets/toggleswitch.dart';
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
      home: MyHomePage(),
      routes: {
      RouteConstants.homeRoute: (context) => MyHomePage(),
      RouteConstants.memoryRoute: (context) => MemoryPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
 


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  @override
  void initState() {
    setState(() {
      ToggleWidget();
    
    });
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
             ToggleWidget(),
        SizedBox(
          width: 0.35*deviceWidth,
        ),
        IconButton(
                icon: Icon(Icons.settings),  //Settings Icon 
                onPressed: () {  },
                ),
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
            ToggleWidgetState().createNewMemory(0),
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

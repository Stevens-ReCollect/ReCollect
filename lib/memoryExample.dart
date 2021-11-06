import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
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
      home: MemoryPage(),
    );
  }
}

class MemoryPage extends StatefulWidget {

  @override
  State<MemoryPage> createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {


  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
  MediaQueryData queryData = MediaQuery.of(context);
  var pixelRatio = queryData.devicePixelRatio; //responsive sizing
  var deviceWidth = queryData.size.width;
  var deviceHeight = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        // App bar properties
        // title: Text(widget.title),
        automaticallyImplyLeading: true,
        backgroundColor: ColorConstants.appBar,
        title: Text('Wedding'), //memory title
        actions: <Widget>[
        
        IconButton(
                icon: Icon(Icons.settings),  //Settings Icon 
                onPressed: () {  },
                ),
        ]
      ),
      body: SingleChildScrollView(
        child: AspectRatio(
        aspectRatio: 100 / 200,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
            padding: EdgeInsets.all(20),
            width: 0.9*deviceWidth,
            child: const Text(
              'This is when you and Grandpa Bobby cut your wedding cake.', style: TextStyle(color: ColorConstants.bodyText, fontSize: TextSizeConstants.bodyText),
            )), //this is where the description will go
           Stack(
             alignment: Alignment.center,
               children: <Widget>[
                 Container(
                   width: 0.8*deviceWidth,
                   height: deviceHeight / 2.5,
                decoration: new BoxDecoration(
                
                image: new DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topLeft, 
                image: AssetImage('lib/images/wedding-placeholder.jpg'), 
                ))),
               ],),
               SizedBox(height: deviceHeight/25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  ElevatedButton(onPressed: (){}, 
                  child: Text('I remember'),
                  style: ElevatedButton.styleFrom(primary: ColorConstants.buttonColor,
                    textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.buttonText)
                  ),),
                  SizedBox(width:10),
                  ElevatedButton(onPressed: (){}, 
                  child: Text("I don't remember"),
                  style: ElevatedButton.styleFrom(primary: ColorConstants.unfavoredButton, 
                    textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.buttonText))
                  ),
                ],)
               ],
             ),
        ),
    ));
  }
}

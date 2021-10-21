import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';

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
  
  var accountMode; //variable for Account Mode

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // App bar properties
        title: Text(widget.title),
        backgroundColor: ColorConstants.appBar,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          DropdownButton<String>(
                value: accountMode,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                iconEnabledColor: ColorConstants.bodyText,
                elevation: 16,
                style: const TextStyle(color: ColorConstants.bodyText, fontSize: TextSizeConstants.dropDownText),
                onChanged: (String? newValue) {
                  setState(() {
                    accountMode = newValue!;
                  });
                },
                items: <String>['Edit Mode', 'Read Only Mode']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              IconButton(
                icon: Icon(Icons.settings),  //Settings Icon 
                onPressed: () {  },)
            ],
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
   
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'New Memories', style: TextStyle(color: ColorConstants.bodyText, fontSize: TextSizeConstants.h2),
            ),
           Container(
             margin: EdgeInsets.all(5),
             width: 341,
             height: 250,
             decoration: BoxDecoration(border: Border.all(color: ColorConstants.hintText), borderRadius: BorderRadius.all(Radius.circular(20))),
             child: Column(
               children: <Widget>[
                 Text('Wedding', style: TextStyle(fontSize: TextSizeConstants.buttonText, fontWeight: FontWeight.w900),),
               ],
             ) 
           ),
          ],
        ),
    ));
  }
}

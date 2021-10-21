import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Welcome'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  var accountMode; //variable for Account Mode

  void _incrementCounter() {
    setState(() {
     
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // App bar properties
        // title: Text(widget.title),
        backgroundColor: ColorConstants.appBar,
        actions: <Widget>[
          Row(
            children: <Widget>[
DropdownButton<String>(
      value: accountMode,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      iconEnabledColor: ColorConstants.bodyText,
      elevation: 16,
      style: const TextStyle(color: ColorConstants.bodyText),
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
        child:Card(
        child: Column(
   
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'New Memories', style: TextStyle(color: ColorConstants.bodyText),
            ),
           Container(
             margin: EdgeInsets.all(5),
             width: 341,
             height: 250,
             decoration: BoxDecoration(border: Border.all(color: ColorConstants.hintText), borderRadius: BorderRadius.all(Radius.circular(20))),
             child: Column(
               children: <Widget>[
                 Text('Wedding'),
               ],
             ) 
           ),
          ],
        ),
      ),
    ));
  }
}

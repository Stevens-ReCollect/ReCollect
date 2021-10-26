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

  var accountMode = "Edit Mode"; //variable for Account Mode

  @override
  void initState() {
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
        leading:  DropdownButton<String>(
                value: accountMode,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                iconEnabledColor: ColorConstants.bodyText,
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: ColorConstants.bodyText, fontSize: TextSizeConstants.dropDownText),
                onChanged: (newValue) {
                  setState(() {
                    accountMode = newValue!;  
                    ColorConstants.isCaregiver = !ColorConstants.isCaregiver;
                  });
                    if (newValue == 'Edit Mode') {
                      OverlayEntry(
                        builder: (context) => Positioned(
                          left: MediaQuery.of(context).size.width * 0.2,
                          top: MediaQuery.of(context).size.height * 0.3,
                          width: 300,
                          child: Material(
                            elevation: 4.0,
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children: <Widget>[
                                Text('Enter the Caregiver pin'),
                                TextFormField(
                                
                                )
                              ],
                            ),
                          ),
                        )
                      );
                    }
                },
                items: <String>['Edit Mode', 'Read Only Mode']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    onTap: (){

                    },
                  );
                }).toList(),
              ),
         
        backgroundColor: ColorConstants.appBar,
        actions: <Widget>[
        IconButton(
                icon: Icon(Icons.settings),  //Settings Icon 
                onPressed: () {  },
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

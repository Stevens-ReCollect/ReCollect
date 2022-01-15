
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/main.dart';
import 'package:recollect_app/widgets/memoryslider.dart';


  
 late String _buttonController; // alerts the correct dialog
 late String affirmTitle;
 late String affirmation; // affirming message

  Widget _affirmingResponse(BuildContext context){
  if(_buttonController == "Yes"){
      affirmTitle = "Great job!";
      affirmation = "Amazing progress.";
  } else if(_buttonController == "Maybe"){
      affirmTitle = "All progress is good progress!";
      affirmation = "Swipe through to see if more moments will help.";
  } else {
      affirmTitle ="It's okay!";
      affirmation = "We can always come back to this moment.";
  }
    return AlertDialog(
        title: Text(affirmTitle,
            style: TextStyle(
              fontSize: TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),
            ), textAlign: TextAlign.center,),
        content: Text(affirmation,
            style: TextStyle(
              fontSize: 0.8*TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText),
            ), textAlign: TextAlign.left,),
        contentPadding: EdgeInsets.all(TextSizeConstants.getadaptiveTextSize(
                  context, TextSizeConstants.bodyText)),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                primary: ColorConstants.buttonColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay',
                style: TextStyle(
                    fontSize: 
                        0.7*TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.buttonText))),
          )
        ]);

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
  
  var accMode = MyHomePageState.accountMode;
  var _isButtonDisabled;

  @override
  void initState() {
     _isButtonDisabled = false;
    super.initState();
  }

  void _isEditMode() {
    if (accMode == 0){
    print('This is Edit Mode');
    setState(() {
      _isButtonDisabled = true;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
  MediaQueryData queryData = MediaQuery.of(context);
//responsive sizing
  var deviceWidth = queryData.size.width;
  var deviceHeight = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        // App bar properties
        // title: Text(widget.title),
        automaticallyImplyLeading: true,
        backgroundColor: ColorConstants.appBar,
        title: Text('Wedding', style: TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.buttonText)),), //memory title
        
      ),
      body: SingleChildScrollView(
        child: AspectRatio(
        aspectRatio: 100 / 200,
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.h2),),
            // Container(
            // padding: EdgeInsets.all(20),
            // width: 0.9*deviceWidth,
            // child: Text("This is when you and Grandpa Bobby cut your wedding cake.", style: TextStyle(color: ColorConstants.bodyText, fontSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),
            // )), 
            //this is where the description will go
            SizedBox(
              width: 0.8*deviceWidth,
              height:0.6*deviceHeight,
            
              child:const Center(child: MemorySlider()),
              
            ),
              //  SizedBox(height: deviceHeight/50),
               Text('Do you remember?', style: TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
               SizedBox(height: deviceHeight/80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  ElevatedButton(
                    onPressed: (){
                    _isButtonDisabled ? null : _isEditMode;
                     //null will get replaced with function that increments memory data
                     _buttonController = "Yes";
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => _affirmingResponse(context)
                        );
                  }, 
                  child: const Text('Yes'),
                  style: ElevatedButton.styleFrom(padding:EdgeInsets.all(deviceWidth/40), primary: ColorConstants.buttonColor,
                    textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.buttonText))
                  ),),
                  SizedBox(width: deviceWidth/40),
                  ElevatedButton(onPressed: (){
                    _isButtonDisabled ? null : _isEditMode; //null will get replaced with function that increments memory data
                  _buttonController = "No";
                 showDialog(
                        context: context,
                        builder: (BuildContext context) => _affirmingResponse(context)
                        );
                  }, 
                  child: const Text("No"),
                  style: ElevatedButton.styleFrom( padding:EdgeInsets.all(deviceWidth/40), primary: ColorConstants.unfavoredButton, 
                    textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.buttonText)))
                  ),
                  SizedBox(width:deviceWidth/40),
                  ElevatedButton(onPressed: (){
                    _isButtonDisabled ? null : _isEditMode; //null will get replaced with function that increments memory data
                  _buttonController = "Maybe";
                   showDialog(
                        context: context,
                        builder: (BuildContext context) => _affirmingResponse(context)
                        );
                  }, 
                  child: const Text("Maybe"),
                  style: ElevatedButton.styleFrom( padding:EdgeInsets.all(deviceWidth/40), primary: ColorConstants.unfavoredButton, 
                    textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.buttonText)))
                  ),
                ],)
               ],
             ),
        ),
    ));
  }
}


// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/main.dart';

class MemoryList {
  final String type;
  final String asset;
  final String description;

  MemoryList(this.type, this.asset, this.description);
 
  
 
}

String firstDesc = 'This is when you and Grandpa Bobby cut your wedding cake.';
MemoryList m  = MemoryList('photo', 'lib/images/wedding-placeholder.jpg', firstDesc);
List  myList = [m, ];
  
selectType(){
    if( m.type == 'photo'){
      return Column(
              children: <Widget>[
                Image.asset(m.asset, fit: BoxFit.fill,),
                
              ],
            );
    } else if( m.type == 'video'){
      return Column(
              children: <Widget>[
                // Find videoplayer package
                Text(m.description,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)
                
              ],
            );
    } else if( m.type == 'audio'){
      return Column(
              children: <Widget>[
                // Find audioplayer package
                Text(m.description,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)
                
              ],
            );
    } else {
      SizedBox();
    }
  }
  

//  createCarousel(){
//   myList.map((i){
//          return Container(
//            child: GestureDetector(
//             child:Stack(
//               children: <Widget>[
//                 selectType(),
//               ],
//             ),
//              onTap: (){
              
//              },
//            ),
//           );
//         });
//   }


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
  var pixelRatio = queryData.devicePixelRatio; //responsive sizing
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
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.h2),),
            Container(
            padding: EdgeInsets.all(20),
            width: 0.9*deviceWidth,
            child: Text(m.description, style: TextStyle(color: ColorConstants.bodyText, fontSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),
            )), 
            //this is where the description will go
            
          
                 selectType(),
              //    Container(
              //      width: 0.8*deviceWidth,
              //      height: deviceHeight / 2.5,
              //   decoration: new BoxDecoration(
                
              //   image: new DecorationImage(
              //   fit: BoxFit.cover,
              //   alignment: Alignment.topLeft, 
              //   image: AssetImage('lib/images/wedding-placeholder.jpg'), 
              //   ))),
                
               SizedBox(height: deviceHeight/30),
               Text('Do you remember?', style: TextStyle(fontSize: TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.bodyText)),),
               SizedBox(height: deviceHeight/80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  ElevatedButton(onPressed: (){
                    _isButtonDisabled ? null : _isEditMode; //null will get replaced with function that increments memory data
                  }, 
                  child: const Text('Yes'),
                  style: ElevatedButton.styleFrom(padding:EdgeInsets.all(deviceWidth/40), primary: ColorConstants.buttonColor,
                    textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.buttonText))
                  ),),
                  SizedBox(width: deviceWidth/40),
                  ElevatedButton(onPressed: (){
                    _isButtonDisabled ? null : _isEditMode; //null will get replaced with function that increments memory data
                  }, 
                  child: const Text("No"),
                  style: ElevatedButton.styleFrom( padding:EdgeInsets.all(deviceWidth/40), primary: ColorConstants.unfavoredButton, 
                    textStyle: TextStyle(fontSize: 0.9*TextSizeConstants.getadaptiveTextSize(context, TextSizeConstants.buttonText)))
                  ),
                  SizedBox(width:deviceWidth/40),
                  ElevatedButton(onPressed: (){
                    _isButtonDisabled ? null : _isEditMode; //null will get replaced with function that increments memory data
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

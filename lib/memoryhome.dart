import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';

class MemoryHomePage extends StatefulWidget {
  @override
  _MemoryHomePageState createState() => _MemoryHomePageState();
}

class _MemoryHomePageState extends State<MemoryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 50.0, left: 10.0),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50.0, left: 260.0),
                  alignment: Alignment.centerRight,
                  // child: Ink(
                  //   decoration: const ShapeDecoration(
                  //     color: ColorConstants.buttonColor,
                  //     shape: CircleBorder(),
                  //   ),
                  // ),
                  child: PopupMenuButton<int>(
                    // onSelected: (value) {
                    //   switch (value) {
                    //     case AddMomentMenu.photo:
                    //       Utils.
                    //   }
                    // },
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: const ShapeDecoration(
                        color: ColorConstants.buttonColor,
                        shape: CircleBorder(),
                      ),
                      child: const Icon(Icons.add,
                          color: ColorConstants.buttonText),
                    ),
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) => [
                      const PopupMenuItem<int>(
                        child: Text('Add Photo'),
                        value: 0,
                      ),
                      const PopupMenuItem<int>(
                        child: Text('Add Video'),
                        value: 1,
                      ),
                      const PopupMenuItem<int>(
                        child: Text('Add Audio'),
                        value: 2,
                      ),
                    ],
                    // .map((item) => PopupMenuItem<String>(
                    //       child: Text(item),
                    //       value: item,
                    //     ))
                    // .toList(),
                  ),
                  // child: IconButton(
                  //   icon: const Icon(Icons.add),
                  //   color: ColorConstants.buttonText,
                  //   onPressed: () {},
                  // ),
                ),
              ],
            ),
            Container(
              height: 36.0,
              width: 325.0,
              margin: const EdgeInsets.only(top: 50.0, left: 0.0),
              child: const Text(
                '{Memory Title Here}',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddMomentMenu {
  static const items = <String>[
    photo,
    video,
    audio,
  ];

  static const String photo = 'Add Photo';
  static const String video = 'Add Video';
  static const String audio = 'Add Audio';
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      print('Clicked Add Photo');
      break;
    case 1:
      print('Clicked Add Video');
      break;
    case 2:
      print('Clicked Add Audio');
      break;
  }
}

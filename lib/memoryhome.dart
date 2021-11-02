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
                  margin: const EdgeInsets.only(top: 50.0, left: 250.0),
                  alignment: Alignment.centerRight,
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: ColorConstants.buttonColor,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      color: ColorConstants.buttonText,
                      onPressed: () {},
                    ),
                  ),
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

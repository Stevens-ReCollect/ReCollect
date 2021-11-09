import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/memoryhome.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/addmoment.dart';

import 'constants/routeConstants.dart';

class CreateMemoryPage extends StatefulWidget {
  @override
  _CreateMemoryPageState createState() => _CreateMemoryPageState();
}

class _CreateMemoryPageState extends State<CreateMemoryPage> {
  String _title = '';
  String _startDate = '';
  String _endDate = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
              margin: const EdgeInsets.only(top: 20.0),
              child: const Center(
                child: Text(
                  'Create a Memory',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Container(
              height: 68.0,
              width: 325.0,
              margin: const EdgeInsets.only(top: 30.0, left: 0.0),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  hintText: 'Example: Christmas 2010',
                ),
              ),
            ),
            Container(
              height: 68.0,
              width: 325.0,
              margin: const EdgeInsets.only(top: 15.0, left: 0.0),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Start Date',
                  hintText: 'MM/DD/YYY',
                ),
              ),
            ),
            Container(
              height: 68.0,
              width: 325.0,
              margin: const EdgeInsets.only(top: 15.0, left: 0.0),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'End Date',
                  hintText: 'MM/DD/YYYY',
                ),
              ),
            ),
            Container(
              height: 250.0,
              width: 325.0,
              margin: const EdgeInsets.only(top: 15.0, left: 0.0),
              child: const TextField(
                maxLines: 15,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  hintText: 'Description',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0, left: 0.0),
              height: 68,
              width: 230,
              child: TextButton(
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      ColorConstants.buttonColor),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      ColorConstants.buttonText),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context, RouteConstants.addMoment);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/signup.dart';

class AddMomentPage extends StatefulWidget {
  @override
  _AddMomentPageState createState() => _AddMomentPageState();
}

class _AddMomentPageState extends State<AddMomentPage> {
  String _title = '';
  String _date = '';
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
                  'Moments',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: const Center(
                child: Text(
                  '{Memory Name}',
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
              margin: const EdgeInsets.only(top: 15.0, left: 0.0),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Type (Video, Audio, Image)',
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
                  labelText: 'Title',
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
                  labelText: 'Date',
                  hintText: 'MM/DD/YYY',
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
                  hintText: 'Desciption',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0, left: 0.0),
              height: 50,
              width: 50,
              child: TextButton(
                child: const Text(
                  '+',
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

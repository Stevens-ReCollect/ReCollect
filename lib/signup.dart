import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/login.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email = '';
  String _password = '';
  int _caregiverpin = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                height: 36.0,
                width: 325.0,
                margin: const EdgeInsets.only(top: 50.0, left: 0.0),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                height: 44.0,
                width: 325.0,
                margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                child: TextButton(
                  child: RichText(
                    text: const TextSpan(
                      text: 'Have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Log in.',
                          style: TextStyle(
                            color: ColorConstants.bodyText,
                            fontSize: 22.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteConstants.loginRoute);
                  },
                ),
              ),
              Container(
                height: 68.0,
                width: 325.0,
                margin: const EdgeInsets.only(top: 30.0, left: 0.0),
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'example@example.com',
                  ),
                ),
              ),
              Container(
                height: 68.0,
                width: 325.0,
                margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                height: 68.0,
                width: 325.0,
                margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                ),
              ),
              Container(
                height: 68.0,
                width: 325.0,
                margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Caregiver Pin',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.info_outlined),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildCaregiverPinPopop(context));
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                height: 68,
                width: 230,
                child: TextButton(
                  child: const Text(
                    'Sign Up',
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
                    Navigator.pushNamed(context, RouteConstants.loginRoute);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCaregiverPinPopop(BuildContext context) {
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        SizedBox(
            width: 300.0,
            height: 100.0,
            child: Text(
                'The Caregiver Pin is the pin you will use to enter back to Edit Mode.')),
      ],
    ),
  );
}

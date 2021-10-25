import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 36.0,
              width: 285.0,
              margin: const EdgeInsets.only(top: 195.0, left: 45.0),
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
              width: 285.0,
              margin: const EdgeInsets.only(top: 15.0, left: 30.0),
              child: TextButton(
                child: const Text(
                  'Have an account? Log in.',
                  style: TextStyle(
                    color: ColorConstants.buttonColor,
                    fontSize: 24.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.left,
                ),
                onPressed: () {},
              ),
            ),
            Container(
              height: 68.0,
              width: 285.0,
              margin: const EdgeInsets.only(top: 30.0, left: 45.0),
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
              width: 285.0,
              margin: const EdgeInsets.only(top: 15.0, left: 45.0),
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
              width: 285.0,
              margin: const EdgeInsets.only(top: 15.0, left: 45.0),
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
              width: 285.0,
              margin: const EdgeInsets.only(top: 15.0, left: 45.0),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Caregiver Pin',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0, left: 45.0),
              height: 68,
              width: 230,
              child: TextButton(
                child: const Text(
                  'Login',
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

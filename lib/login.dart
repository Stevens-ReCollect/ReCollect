import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/main.dart';
import 'package:recollect_app/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';

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
                  'Log In',
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
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign up.',
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
                    Navigator.pushNamed(context, RouteConstants.signupRoute);
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
                margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                height: 68,
                width: 230,
                child: TextButton(
                  child: const Text(
                    'Log In',
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
                    Navigator.pushNamed(context, RouteConstants.homeRoute);
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

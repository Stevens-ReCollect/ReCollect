import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:recollect_app/firebase/authentication_service.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/firebase/firestore_service.dart';
import 'package:recollect_app/main.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/tutorial.dart';
import 'package:recollect_app/forgotpassword.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String logInResult = "";
  Color logInResultColor = Colors.red;
  int counterResult = 0;
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(),
              Container(
                width: 0.8 * deviceWidth,
                margin: const EdgeInsets.only(top: 50.0, left: 0.0),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.memoryTitle),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: 0.8 * deviceWidth,
                margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                child: TextButton(
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.bodyText),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign up.',
                          style: TextStyle(
                            color: ColorConstants.bodyText,
                            fontSize: TextSizeConstants.getadaptiveTextSize(
                                context, TextSizeConstants.bodyText),
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
                width: 0.8 * deviceWidth,
                margin: const EdgeInsets.only(top: 10.0, left: 0.0),
                child: Text(
                  logInResult,
                  style: TextStyle(
                    color: logInResultColor,
                    fontSize: TextSizeConstants.getadaptiveTextSize(
                        context, TextSizeConstants.hint),
                  ),
                ),
              ),
              Container(
                width: 0.8 * deviceWidth,
                margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontSize: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.formField)),
                    hintText: 'example@example.com',
                    hintStyle: TextStyle(
                        fontSize: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.formField)),
                  ),
                ),
              ),
              Container(
                width: 0.8 * deviceWidth,
                margin: const EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        fontSize: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.formField)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                height: 2.5 * TextSizeConstants.bodyText,
                width: 0.5 * deviceWidth,
                child: TextButton(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.bodyText),
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
                    onPressed: _isButtonDisabled
                        ? null
                        : () async {
                            setState(() {
                              _isButtonDisabled = true;
                            });
                            await AuthenticationService()
                                .signIn(
                                    email: _email.text,
                                    password: _password.text)
                                .then((String result) {
                              setState(() {
                                logInResult = result;
                              });
                            });

                            print(logInResult);
                            if (logInResult == "Success!") {
                              logInResultColor = Colors.green;
                              await FirestoreService()
                                  .getCounter(
                                      email: _email.text,
                                      password: _password.text)
                                  .then((int counter) {
                                setState(() {
                                  counterResult = counter;
                                });
                              });

                              if (counterResult == 0) {
                                Navigator.pushNamed(
                                    context, RouteConstants.tutorialRoute);
                                await FirestoreService().editCounter(
                                    email: _email.text,
                                    password: _password.text);
                              } else {
                                Navigator.pushNamed(
                                    context, RouteConstants.navigationRoute);
                              }
                            } else {
                              setState(() {
                                _isButtonDisabled = false;
                              });
                            }
                          }),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                height: 2.5 * TextSizeConstants.bodyText,
                width: 0.5 * deviceWidth,
                child: TextButton(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.bodyText),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.unfavoredButton),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.buttonText),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteConstants.forgotRoute);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

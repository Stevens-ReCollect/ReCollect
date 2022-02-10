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
import 'package:recollect_app/login.dart';
import 'package:recollect_app/main.dart';
import 'package:recollect_app/signup.dart';
import 'package:recollect_app/tutorial.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _email = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String logInResult = "";
  int counterResult = 0;
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
    return MaterialApp(
      home: Form(
        key: _key,
        child: Scaffold(
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
                    'Reset Password',
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
                  child: Text(
                    'Please enter email to receive password reset link to your email.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.bodyText),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  width: 0.8 * deviceWidth,
                  margin: const EdgeInsets.only(top: 10.0, left: 0.0),
                  child: Text(
                    logInResult,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: TextSizeConstants.getadaptiveTextSize(
                          context, TextSizeConstants.hint),
                    ),
                  ),
                ),
                Container(
                  width: 0.8 * deviceWidth,
                  margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                  child: TextFormField(
                    controller: _email,
                    validator: AuthenticationService().validateEmail,
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
                  margin: const EdgeInsets.all(15.0),
                  height: 2.5 * TextSizeConstants.bodyText,
                  width: 0.5 * deviceWidth,
                  child: TextButton(
                      child: Text(
                        'Submit',
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                              if (_key.currentState!.validate()) {
                                await AuthenticationService()
                                    .resetPassword(email: _email.text)
                                    .then((String result) {
                                  setState(() {
                                    logInResult = result;
                                  });
                                });
                              }

                              print("A password reset link was sent to $_email");
                              if (logInResult == "Success") {
                                Navigator.pushNamed(
                                    context, RouteConstants.loginRoute);
                              } else {
                                setState(() {
                                  _isButtonDisabled = false;
                                });
                              }
                            }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

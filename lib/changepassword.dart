import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:recollect_app/firebase/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/login.dart';
import 'package:recollect_app/progressReport.dart';
import 'package:recollect_app/navigation.dart';
import 'package:recollect_app/startup.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String confirmResult = "";

  String checkCurrentPasswordValid = "";

  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password is required.';
    }

    if (confirmPassword != _newPassword.text) {
      return 'Passwords do not match.';
    }

    return null;
  }

  String? validateCurrentPassword(String? currentPassword) {
    if (currentPassword == null || currentPassword.isEmpty) {
      return 'Your Password is required.';
    }

    if (checkCurrentPasswordValid == "") {
      return "Please double check your current password.";
    }

    return null;
  }

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
                    'Change Password',
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
                  // margin: const EdgeInsets.only(top: 15.0, left: 0.0),
                  child: TextButton(
                    child: RichText(
                      text: TextSpan(
                        text: 'Please enter your email and password.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: TextSizeConstants.getadaptiveTextSize(
                              context, TextSizeConstants.bodyText),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {},
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
                  width: 0.8 * deviceWidth,
                  margin: const EdgeInsets.only(top: 30.0, left: 0.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: _currentPassword,
                    validator: AuthenticationService().validatePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Current Password',
                      labelStyle: TextStyle(
                          fontSize: TextSizeConstants.getadaptiveTextSize(
                              context, TextSizeConstants.formField)),
                    ),
                  ),
                ),
                Container(
                  width: 0.8 * deviceWidth,
                  margin: const EdgeInsets.only(top: 30.0, left: 0.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: _newPassword,
                    validator: AuthenticationService().validatePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                      labelStyle: TextStyle(
                          fontSize: TextSizeConstants.getadaptiveTextSize(
                              context, TextSizeConstants.formField)),
                    ),
                  ),
                ),
                Container(
                  width: 0.8 * deviceWidth,
                  margin: const EdgeInsets.only(top: 30.0, left: 0.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: _confirmPassword,
                    validator: validateConfirmPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                          fontSize: TextSizeConstants.getadaptiveTextSize(
                              context, TextSizeConstants.formField)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30.0, left: 0.0),
                  height: 2.5 * TextSizeConstants.bodyText,
                  width: 0.5 * deviceWidth,
                  child: TextButton(
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: TextSizeConstants.getadaptiveTextSize(
                            context, TextSizeConstants.buttonText),
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
                    onPressed: () async {
                      print('pressed');
                      await AuthenticationService()
                          .validateCurrentPassword(
                              _email.text, _currentPassword.text)
                          .then((String result) {
                        print(result);
                        setState(() {
                          checkCurrentPasswordValid = result;
                        });
                      });

                      if (_key.currentState!.validate() &&
                          checkCurrentPasswordValid == "Success") {
                        await AuthenticationService()
                            .updatePassword(_newPassword.text);

                        print("Your password has been changed");
                        await AuthenticationService()
                            .signOut()
                            .then((String result) {
                          setState(() {
                            confirmResult = result;
                          });
                        });

                        print(confirmResult);
                        if (confirmResult == "Signed Out") {
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        StartUpPage(),
                                  ),
                                  (route) => false);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:recollect_app/firebase/authentication_service.dart';
import 'package:recollect_app/constants/colorConstants.dart';
import 'package:recollect_app/constants/routeConstants.dart';
import 'package:recollect_app/constants/textSizeConstants.dart';
import 'package:recollect_app/main.dart';
import 'package:recollect_app/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width;
    var deviceHeight = queryData.size.height;
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
                margin: const EdgeInsets.only(top: 30.0, left: 0.0),
                child: TextField(
                  controller: email,
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
                  controller: password,
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
                height: 68,
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
                  onPressed: () {
                    context.read<AuthenticationService>().signIn(
                        email: email.text,
                        password: password.text);
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

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartUpPage(),
    );
  }
}

class StartUpPage extends StatefulWidget {
  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: const <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 320.0),
              child: Center(
                  child: Text(
                'ReCollect',
                style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w900),
              ))),
          Padding(
              padding: EdgeInsets.only(top: 450.0),
              child: Center(
                child: ElevatedButton(onPressed: () {}, child: Text('Login')),
              ))
        ])));
  }
}

void run() => {};

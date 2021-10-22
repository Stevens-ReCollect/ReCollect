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
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 320.0),
              child: Center(
                child: Text(
                  'ReCollect',
                  style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 68.0),
              height: 68,
              width: 230,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                child: const Text('Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 24.0)),
                onPressed: () {},
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 22.0),
              height: 68,
              width: 230,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                child: const Text('Login',
                    style: TextStyle(color: Colors.white, fontSize: 24.0)),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

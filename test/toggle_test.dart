
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recollect_app/main.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() {
  Widget createWidgetForTesting({required Widget child}){
return MaterialApp(
  home: child,
);
}
  testWidgets('Home Page screen loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(createWidgetForTesting(child:MyHomePage()));
    // Verify Listener
    expect(find.byType(Listener), findsNWidgets(1));

  });
}

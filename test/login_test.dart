import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recollect_app/login.dart';

void main() {
  testWidgets('Log In screen loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(LoginPage());

    tester.state(find.text('Log In'));
    // Widget testWidget = new MediaQuery(
    //     data: new MediaQueryData(),
    //     child: new MaterialApp(home: new LoginPage()));

    // Verify app title appears
    // expect(find.text('Log In'), findsOneWidget);

    // Verify Login and Sign Up button appears
    // expect(find.byType(TextButton), findsNWidgets(2));

    // Verify TextField appears
    // expect(find.byType(TextField), findsNWidgets(2));
    // Need to test colors are correct
  });
}

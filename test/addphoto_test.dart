import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recollect_app/login.dart';

void main() {
  testWidgets('Log In screen loads correctly', (WidgetTester tester) async {
    // Build the app
    Widget testWidget = MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
    await tester.pumpWidget(testWidget);

    // Verify app title appears
    expect(find.text('Log In'), findsNWidgets(2));

    // Verify Login and Sign Up button appears
    expect(find.byType(TextButton), findsNWidgets(2));

    // Verify TextField appears
    expect(find.byType(TextField), findsNWidgets(2));
    // Need to test colors are correct
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recollect_app/signup.dart';

void main() {
  testWidgets('Sign Up screen loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(SignUpPage());

    // Verify app title appears
    expect(find.text('Sign Up'), findsOneWidget);

    // Verify Login and Sign Up button appears
    expect(find.byType(TextButton), findsNWidgets(2));

    // Verify TextField appears
    expect(find.byType(TextField), findsNWidgets(4));
    // Need to test colors are correct
  });
}

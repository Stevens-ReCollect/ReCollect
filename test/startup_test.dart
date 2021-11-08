import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recollect_app/startup.dart';

void main() {
  testWidgets('Startup screen loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(StartUp());

    // Verify app title appears
    expect(find.text('ReCollect'), findsOneWidget);

    // Verify buttons appears
    expect(find.byType(TextButton), findsNWidgets(2));
    // Need to test colors are correct
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recollect_app/addphoto.dart';

void main() {
  testWidgets('Add Photo screen loads correctly', (WidgetTester tester) async {
    // Build the app
    Widget testWidget = MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: AddPhotoPage(),
      ),
    );
    await tester.pumpWidget(testWidget);

    // Verify page title appears
    expect(find.text('Photo Selected'), findsNWidgets(1));

    // Verify Change Photo and Save button appears
    expect(find.byType(TextButton), findsNWidgets(2));

    // Verify Description appears
    expect(find.byType(TextField), findsNWidgets(1));
    // Need to test colors are correct
  });
}


import 'package:flutter_test/flutter_test.dart';

import 'package:recollect_app/main.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() {
  testWidgets('Home Page screen loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyHomePage());

    // Verify 'New Memories' appears
    expect(find.text('New Memories'), findsNWidgets(1));

    //Verify the two modes appear
    expect(find.text('Edit Mode'), findsNWidgets(1));
    expect(find.text('Story Mode'), findsNWidgets(1));
    // Verify Toggle Switch appears
    expect(find.byType(ToggleSwitch), findsNWidgets(1));

  });
}

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:recollect_app/signup.dart';

// Future<void> main() async {
//   testWidgets('Sign Up screen loads correctly', (WidgetTester tester) async {
//     // Build the app
//     await Firebase.initializeApp();
//     Widget testWidget = MediaQuery(
//       data: const MediaQueryData(),
//       child: MaterialApp(
//         home: SignUpPage(),
//       ),
//     );
//     await tester.pumpWidget(testWidget);

//     // Verify app title appears
//     expect(find.text('Sign Up'), findsNWidgets(2));

//     // Verify Login and Sign Up button appears
//     expect(find.byType(TextButton), findsNWidgets(2));

//     // Verify TextField appears
//     expect(find.byType(TextFormField), findsNWidgets(4));
//     // Need to test colors are correct
//   });
// }

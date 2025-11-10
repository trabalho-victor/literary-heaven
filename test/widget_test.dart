import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:literary_heaven/screens/login.dart';

void main() {
  testWidgets('Login screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyLogin(),
    ));

    // Verify that the welcome text is present.
    expect(find.text('Welcome to Literary Haven'), findsOneWidget);
    
    // Verify that the login button is present.
    expect(find.text('Log In'), findsOneWidget);
  });
}

// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music/main.dart'; // Sesuaikan dengan lokasi MyApp Anda

void main() {
  testWidgets('Login Page Test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the LoginPage is displayed.
    expect(find.text('Login Trebel'), findsOneWidget);

    // Tap the 'Register' button and trigger a frame.
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    // Verify that the RegisterPage is displayed.
    expect(find.text('Register Trebel'), findsOneWidget);
  });
}

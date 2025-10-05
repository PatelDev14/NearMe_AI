/*a basic widget test that pumps your app's root widget (NearMeApp) and asserts the app builds a MaterialApp. Use this as a template for more specific UI tests (find text, buttons, navigation).*/
import 'package:flutter_test/flutter_test.dart';//Unit testing framework for Flutter.
import 'package:nearme_ai/app.dart';//Testing the main app widget.
import 'package:flutter/material.dart';

void main() {
  testWidgets('App builds and provides a MaterialApp', (WidgetTester tester) async {
    // Build the real app.
    await tester.pumpWidget(const NearMeApp());

    // Let the framework build frames.
    await tester.pumpAndSettle();

    // Basic sanity checks: a MaterialApp should be present.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
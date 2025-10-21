import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:di_step0/main.dart';

void main() {
  testWidgets('DI Step 0 smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app shows the correct title
    expect(find.text('DI Step 0 - Basic Classes'), findsOneWidget);
    expect(find.text('Basic Classes without DI'), findsOneWidget);
  });
}

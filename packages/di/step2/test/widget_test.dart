import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:di_step2/main.dart';

void main() {
  testWidgets('DI Step 2 smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app shows the correct title
    expect(find.text('DI Step 2 - GetIt with Interfaces'), findsOneWidget);
    expect(find.text('GetIt with Interfaces and Dependency Inversion'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:di_step1/main.dart';

void main() {
  testWidgets('DI Step 1 smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app shows the correct title
    expect(find.text('DI Step 1 - Basic GetIt'), findsOneWidget);
    expect(find.text('Basic GetIt with Singleton Pattern'), findsOneWidget);
  });
}

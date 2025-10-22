// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:go_router_demo/main.dart';

void main() {
  testWidgets('Go Router Demo smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GoRouterDemoApp());

    // Verify that our app starts with home screen
    expect(find.text('Go Router Demo'), findsOneWidget);
    expect(find.text('Go Router Navigation Examples'), findsOneWidget);
  });
}
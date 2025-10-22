// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:navigation_basic/main.dart';

void main() {
  testWidgets('Navigation Basic Demo smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NavigationBasicApp());

    // Verify that our app starts with the home screen
    expect(find.text('Navigation Basic Demo'), findsOneWidget);
    expect(find.text('Push - Dodaj nowy ekran'), findsOneWidget);
  });
}

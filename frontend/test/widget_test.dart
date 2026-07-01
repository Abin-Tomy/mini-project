import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/main.dart';

void main() {
  testWidgets('App renders login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const HealthAIApp());

    // Verify that the login screen is displayed
    expect(find.text('HealthAI'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}

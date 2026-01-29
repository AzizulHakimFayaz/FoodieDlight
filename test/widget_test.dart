// This is a basic Flutter widget test.

import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivary/main.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FoodOrderingApp());

    // Verify that the home page is displayed.
    // We can look for a text that is likely to be on the home page.
    expect(find.text('FoodieDelight'), findsWidgets);
  });
}

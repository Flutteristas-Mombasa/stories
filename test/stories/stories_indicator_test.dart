import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stories/stories/stories_indicator.dart';

void main() {
  group('StoriesIndicator', () {
    // Test for when 'read' is true (indicator should be white)
    testWidgets('renders white when read is true', (WidgetTester tester) async {
      // Build the StoriesIndicator with 'read' set to true
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StoriesIndicator(read: true, width: 20),
        ),
      ));

      // Ensure the widget tree has settled
      await tester.pumpAndSettle();

      // Verify that the color is white
      final container =
          tester.widget(find.byType(Container).first) as Container;
      final decoration = container.decoration as BoxDecoration;
      expect(
          decoration.color, Colors.white); // Should be white if 'read' is true
    });

    // Test for when 'read' is false (indicator should be grey)
    testWidgets('renders grey when read is false', (WidgetTester tester) async {
      // Build the StoriesIndicator with 'read' set to false
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StoriesIndicator(read: false, width: 20),
        ),
      ));

      // Ensure the widget tree has settled
      await tester.pumpAndSettle();

      // Verify that the color is grey
      final container =
          tester.widget(find.byType(Container).first) as Container;
      final decoration = container.decoration as BoxDecoration;
      expect(
          decoration.color, Colors.grey); // Should be grey if 'read' is false
    });

    // Test for correct width
    testWidgets('renders with correct width', (WidgetTester tester) async {
      // Width is set to 20
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StoriesIndicator(read: false, width: 20),
        ),
      ));

      // Ensure the widget tree has settled
      await tester.pumpAndSettle();

      // Verify the width of the container is correct
      final container =
          tester.widget(find.byType(Container).first) as Container;
      final constraints = container.constraints;
      expect(constraints?.maxWidth, 20); // The width should be 20
    });
  });
}

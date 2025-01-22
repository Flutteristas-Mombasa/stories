import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stories/main.dart';
import 'package:stories/stories/stories_indicator.dart'; // For Timer

void main() {
  group('MyHomePage', () {
    testWidgets('initial page shows first story and indicator',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(MaterialApp(
        home: MyHomePage(title: 'Test Home Page'),
      ));

      // Ensure the widget tree has settled
      await tester.pumpAndSettle();

      // Verify that the first story's title and description are displayed
      expect(find.text('John Doe'),
          findsOneWidget); // Assuming "John Doe" is the title of the first story
      expect(find.text('Lorem Ipsum'),
          findsOneWidget); // Assuming the description of the first story

      // Verify that the first indicator is marked as "read"
      expect(find.byType(StoriesIndicator),
          findsNWidgets(7)); // Ensure we have 7 indicators
      final firstIndicator = tester.widget(find.byType(StoriesIndicator).first)
          as StoriesIndicator;
      expect(firstIndicator.read, true); // The first indicator should be "read"

      // Ensure that the second indicator is not "read"
      final secondIndicator = tester.widget(find.byType(StoriesIndicator).at(1))
          as StoriesIndicator;
      expect(secondIndicator.read,
          false); // The second indicator should be "unread"
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stories/stories/story_data.dart';
import 'package:stories/stories/story_full_page_widget.dart';

void main() {
  group('StoryFullPageWidget', () {
    // Test when StoryData is provided
    testWidgets('renders title, description, and background color correctly',
        (WidgetTester tester) async {
      // Create a sample StoryData object
      final storyData = StoryData(
        color: Colors.blue, // Custom background color
        title: 'Sample Story',
        description: 'This is a sample story description.',
      );

      // Build the StoryFullPageWidget with the provided StoryData
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StoryFullPageWidget(storyData: storyData),
        ),
      ));

      // Ensure the widget tree has settled
      await tester.pumpAndSettle();

      // Check if the title and description are rendered correctly
      expect(find.text('Sample Story'), findsOneWidget);
      expect(find.text('This is a sample story description.'), findsOneWidget);

      // Check if the background color is applied
      final decoratedBox =
          tester.widget(find.byType(DecoratedBox).first) as DecoratedBox;
      final decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.color, Colors.blue); // Verify the background color
    });

    // Test when StoryData is not provided
    testWidgets(
        'renders default title, description, and background color when StoryData is null',
        (WidgetTester tester) async {
      // Build the StoryFullPageWidget with no StoryData (defaults)
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StoryFullPageWidget(),
        ),
      ));

      // Ensure the widget tree has settled
      await tester.pumpAndSettle();

      // Check if the title and description are empty (because StoryData is null)
      expect(find.text(''),
          findsNWidgets(2)); // Expect two empty texts (title and description)

      // Check if the background color defaults to redAccent
      final decoratedBox =
          tester.widget(find.byType(DecoratedBox).first) as DecoratedBox;
      final decoration = decoratedBox.decoration as BoxDecoration;
      expect(
          decoration.color, Colors.redAccent); // Default color if no StoryData
    });
  });
}

import 'package:flutter/material.dart';
import 'package:stories/stories/story_data.dart';

// This widget represents a single full-page story. It uses a custom StoryData object to display the content.
class StoryFullPageWidget extends StatelessWidget {
  // Constructor for passing in StoryData, which contains the story details (color, title, description)
  const StoryFullPageWidget({super.key, this.storyData});

  // The StoryData object holds the color, title, and description for each story
  final StoryData? storyData;

  @override
  Widget build(BuildContext context) {
    return Material(
      // Material widget to ensure the page has appropriate visual effects (e.g., shadows)
      child: SizedBox(
        // Full screen size (height and width of the device)
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          // Stack allows overlaying widgets on top of each other (background color + content)
          children: [
            // The background of the page. It takes the full space and is decorated with a color.
            SizedBox.expand(
              child: DecoratedBox(
                // The background color of the story, based on the StoryData. If none is provided, a default color is used.
                decoration: BoxDecoration(
                  color: storyData?.color ??
                      Colors
                          .redAccent, // Default to redAccent if no color is passed
                ),
              ),
            ),
            // Aligning the story's content (title, subtitle, icons) at the bottom of the page
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                // Leading icon: a person icon representing the user or author of the story
                leading: Icon(Icons.person),

                // Trailing icon: a more options icon, usually for additional actions (e.g., menu)
                trailing: Icon(Icons.more_vert),

                // Subtitle: A description of the story, provided by StoryData. If no description is provided, an empty string is shown.
                subtitle: Text(storyData?.description ?? ''),

                // Title: The title of the story, provided by StoryData. If no title is provided, an empty string is shown.
                title: Text(storyData?.title ?? ''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

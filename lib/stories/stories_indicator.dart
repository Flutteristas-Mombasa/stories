import 'package:flutter/material.dart';

// This is a custom widget that represents an individual page indicator (e.g., a dot) in the story view
class StoriesIndicator extends StatelessWidget {
  // Constructor with optional parameters for 'read' status and 'width'
  const StoriesIndicator({super.key, this.read, this.width});

  // 'read' determines if the indicator should look active or inactive
  final bool? read;

  // 'width' defines the width of the indicator, which varies based on screen size and number of pages
  final double? width;

  @override
  Widget build(BuildContext context) {
    // Building the widget layout for the indicator
    return Container(
      // Small margin to the left of each indicator, creating space between them
      margin: EdgeInsets.only(left: 2),

      // Fixed height for each indicator, making it appear like a small circle or dot
      height: 10,

      // The width of the indicator is dynamically set from the parent widget (e.g., based on the screen width)
      width: width,

      decoration: BoxDecoration(
        // Rounded corners to make the indicator a pill-shaped or circular look
        borderRadius: BorderRadius.circular(8),

        // Color changes based on the 'read' status
        color: (read ?? false)
            ? Colors.white
            : Colors.grey, // If 'read' is true, set color to white; else grey
      ),
    );
  }
}

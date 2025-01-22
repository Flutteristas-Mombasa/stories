import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stories/stories/stories_indicator.dart';
import 'package:stories/stories/story_data.dart';
import 'package:stories/stories/story_full_page_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// Variable to track the current index of the displayed story
  int currentIndex = 0;

// A list of story pages, each represented by a `StoryFullPageWidget`
  final stories = [
    StoryFullPageWidget(
      storyData: StoryData(
          color: Colors.amber, description: 'Lorem Ipsum', title: 'John Doe'),
    ),
    StoryFullPageWidget(
      storyData: StoryData(
          color: Colors.purple,
          description: 'Using the first of multiple matching destinations',
          title: 'Jane Doe'),
    ),
    StoryFullPageWidget(
      storyData: StoryData(
          color: Colors.green,
          description: ' The test run did not record any output.',
          title: 'Peter Doe'),
    ),
    StoryFullPageWidget(
      storyData: StoryData(
          color: Colors.lightBlue,
          description: 'Using the first of multiple matching destinations',
          title: 'Arya Doe'),
    ),
    StoryFullPageWidget(
      storyData: StoryData(
          color: Colors.amber,
          description: 'Using the first of multiple matching destinations',
          title: 'Alice DOe'),
    ),
    StoryFullPageWidget(
      storyData: StoryData(
          color: Colors.purple,
          description: 'Using the first of multiple matching destinations',
          title: 'Bob Doe'),
    ),
    StoryFullPageWidget(
      storyData: StoryData(
          color: Colors.green,
          description: 'The test run did not record any output.',
          title: 'John Wick'),
    ),
  ];

// Declare the PageController as a late variable to control page navigation
  late PageController pageController;

// Declare a Timer? variable to hold the timer reference
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    // Initialize the PageController when the widget is first created
    pageController = PageController();

    // Set up a periodic timer to automatically navigate to the next page every 4 seconds
    _timer = Timer.periodic(Duration(seconds: 4), (Timer r) {
      _animateToNextPage(); // Call function to animate to the next page
    });
  }

// Function to handle the animation of transitioning to the next page
  void _animateToNextPage() {
    // Ensure we are not trying to go past the last page
    if (currentIndex < stories.length - 1) {
      // Animate to the next page with a smooth transition and a 5-second duration
      pageController.animateToPage(currentIndex + 1,
          duration: Duration(seconds: 3), // Duration of the animation
          curve: Curves.bounceInOut); // The easing curve for smooth animation
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The main structure of the page is a Stack widget, which allows overlapping widgets
      body: Stack(
        children: [
          // PageView.builder creates a scrollable list of pages (story pages in this case)
          PageView.builder(
            // The controller that manages the PageView and its current page
            controller: pageController,

            // The number of pages (stories) to be displayed
            itemCount: stories.length,

            // This callback is triggered when the page changes (e.g., swipe left/right)
            onPageChanged: (i) {
              setState(() {
                // Update the current index when the user changes the page
                currentIndex = i;
              });
            },

            // Builds each page widget from the `stories` list
            itemBuilder: (_, i) => stories[i],
          ),

          // Positioned widget to overlay indicators on top of the PageView
          Align(
            alignment:
                Alignment.topCenter, // Aligning the indicator at the top center
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 18.0), // Giving some padding from the top
              child: SizedBox(
                height: 20, // The height of the indicator row
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the indicators
                  children: List.generate(
                    // Generate the correct number of indicator widgets (based on the number of stories)
                    stories.length,
                    (i) => StoriesIndicator(
                      width: MediaQuery.of(context).size.width *
                          .96 /
                          stories
                              .length, // Width of each indicator based on screen size
                      read: i <=
                          currentIndex, // Set 'read' status (checked if the page is in the past)
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

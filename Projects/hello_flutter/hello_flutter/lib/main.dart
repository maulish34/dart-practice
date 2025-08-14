// 1. Import the Material library, which contains all the Material Design widgets.
import 'package:flutter/material.dart';
import 'profile_card.dart';

// 2. The main() function is the entry point for the app.
//    runApp() tells Flutter to run the given widget as the root of the app.
void main() {
  runApp(const MyApp());
}

// 3. MyApp is the root widget of your application. It's a StatelessWidget
//    because it won't change over time.
class MyApp extends StatelessWidget {
  // The 'key' is used by Flutter to uniquely identify widgets.
  const MyApp({super.key});

  // 4. The 'build' method describes how to display the widget.
  //    It's called by the Flutter framework whenever the widget needs to be drawn.
  @override
  Widget build(BuildContext context) {
    // 5. MaterialApp is a wrapper that provides many features needed for an app,
    //    like theming and navigation.
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE3F2FD), Color(0xFFF1F8E9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: ProfileCard(),
          ),
        ),
      ),
    );
  }
}

// ...existing code...
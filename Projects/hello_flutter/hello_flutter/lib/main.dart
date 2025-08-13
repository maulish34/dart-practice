// 1. Import the Material library, which contains all the Material Design widgets.
import 'package:flutter/material.dart';

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
      // 6. Scaffold is a basic layout for a Material Design page.
      home: Scaffold(
        // 7. Center is a layout widget that centers its child.
        body: Center(
          // 8. Text is the widget that displays text.
          child: Text('Hello, Flutter!', style: TextStyle(background: Paint()..color = Colors.yellow, 
            // 9. The style property allows you to customize the text appearance.
            
              fontSize: 24, // Set the font size to 24 pixels.
              color: Colors.black, // Set the text color to black.
            ),
          ),
        ),
      ),
    );
  }
}
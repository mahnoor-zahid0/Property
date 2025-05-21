import 'package:flutter/material.dart';
import 'home.dart';  // Import the HomePage

void main() {
  runApp(const MyApp());  // Wrap the app in MaterialApp
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Initial theme mode is set to light
  bool _isDarkMode = false;

  // Toggle the theme mode
  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,  // Switch theme based on the toggle
      theme: ThemeData(
        // Light theme settings
        brightness: Brightness.light,
        primaryColor: Color(0xFF003B5C), // Deep Navy Blue for trust
        secondaryHeaderColor: Color(0xFF26A69A), // Warm Beige
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),  // Text color for light mode
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFF8F4E3),
          foregroundColor: Color(0xFF2C3E50),
        ),
        iconTheme: IconThemeData(color: Color(0xFF2C3E50)), // Icon color
        colorScheme: ColorScheme.light(
          primary: Color(0xFF003B5C), // Primary color for light theme
          secondary: Color(0xFF26A69A), // Background color
          surface: Color(0xFFF5F5F5), // Surface color for light theme
        ),
      ),
      darkTheme: ThemeData(
        // Dark theme settings
        brightness: Brightness.dark,
        primaryColor: Color(0xFF1E3A8A), // Trust Blue (Deep Navy)
        secondaryHeaderColor: Color(0xFF26A69A), // Dark background color
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),  // Text color for dark mode
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF333333),
          foregroundColor: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white), // Icon color in dark mode
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF1E3A8A), // Primary color for dark theme
          secondary: Color(0xFF26A69A), // Dark background color
          surface: Color(0xFF1E1E1E), // Surface color for dark theme
        ),
      ),
      home: HomePage(toggleDarkMode: _toggleDarkMode), // Pass toggle to the HomePage
    );
  }
}

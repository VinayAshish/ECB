import 'package:ecomplaintbharat/screens/homepage.dart';
import 'package:ecomplaintbharat/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase initialization
import 'package:ecomplaintbharat/splash_screen.dart'; // Your splash screen import
import 'package:ecomplaintbharat/authentication/firebase_options.dart'; // Firebase configuration ( generated from Firebase CLI )
import 'package:shared_preferences/shared_preferences.dart'; // Backend: Import SharedPreferences

void main() async {
  // Ensure widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get instance of SharedPreferences5
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if user is logged in
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Run the app with the initial route based on login state
  runApp(EcbApp(initialRoute: '/splash')); // Start with the splash screen
}

class EcbApp extends StatelessWidget {
  final String initialRoute;

  const EcbApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(200, 200, 200, 200),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute, // Set initial route to splash screen
      routes: {
        '/splash': (context) => const SplashScreen(), // Splash screen route
        '/signin': (context) => SignInScreen(), // Sign-in route
        '/homepage': (context) => Homepage(), // Homepage route
      },
      home: const SplashScreen(), // Default to SplashScreen
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Import your screens
import 'views/home_screen.dart';
import 'views/plans_screen.dart';
import 'views/run_screen.dart';
import 'views/club_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  runApp(FitQuestApp());
}

class FitQuestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitQuest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Your initial/home screen
      home: HomeScreen(),

      // Named routes for navigation
      routes: {
        '/home': (context) => HomeScreen(),
        '/plans': (context) => PlansScreen(),
        '/run': (context) => RunScreen(),
        '/club': (context) => ClubScreen(),
        // Add any other screens here
      },

      // Optional: handle unknown routes gracefully
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}

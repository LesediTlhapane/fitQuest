import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'viewmodels/auth_vm.dart';
import 'viewmodels/run_vm.dart'; // Add this import
import 'services/auth_service.dart';
import 'views/welcome_screen.dart';
import 'views/login_screen.dart';
import 'views/signup_screen.dart';
import 'views/home_screen.dart';
import 'views/profile_screen.dart';
import 'views/run_screen.dart';
import 'views/club_screen.dart';
import 'views/activity_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (_) => AuthViewModel(AuthService()),
    ),
    ChangeNotifierProvider(
      create: (_) => RunViewModel(), // Make sure this is here
    ),
  ],
      child: MaterialApp(
        title: 'FitQuest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthWrapper(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/run': (context) => const RunScreen(),
          '/clubs': (context) => const ClubScreen(),
          '/activity': (context) => const ActivityScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    
    if (auth.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (auth.isLoggedIn) {
      return const HomeScreen();
    }

    return const WelcomeScreen();
  }
}
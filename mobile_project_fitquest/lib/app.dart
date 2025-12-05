import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';
import 'views/home_screen.dart';
import 'views/plans_screen.dart';
import 'views/run_screen.dart';
import 'views/club_screen.dart';
import 'views/activity_screen.dart';
import 'views/login_screen.dart';
import 'views/signup_screen.dart';

import 'widgets/bottom_nav.dart';

import 'viewmodels/auth_vm.dart';
import 'viewmodels/run_vm.dart';
import 'services/firebase_service.dart';

class FitQuestApp extends StatefulWidget {
  const FitQuestApp({super.key});

  @override
  State<FitQuestApp> createState() => _FitQuestAppState();
}

class _FitQuestAppState extends State<FitQuestApp> {
  int _currentIndex = 0;
  late final FirebaseService firebaseService;

  @override
  void initState() {
    super.initState();
    firebaseService = FirebaseService();
  }

  Widget _mainApp() {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(),
          const PlansScreen(),
          const RunScreen(),
          ClubScreen(),
          ActivityScreen(),
        ],
      ),
      bottomNavigationBar: FitQuestBottomNav(
        index: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(firebaseService)),
        ChangeNotifierProvider(create: (_) => RunViewModel()),
      ],
      child: MaterialApp(
        title: 'FitQuest',
        theme: fitQuestTheme,
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthViewModel>(
          builder: (context, auth, _) {
            if (auth.loading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (auth.isLoggedIn) {
              return _mainApp();
            }

            return const LoginScreen();
          },
        ),
        routes: {
          '/signup': (_) => const SignUpScreen(),
        },
      ),
    );
  }
}

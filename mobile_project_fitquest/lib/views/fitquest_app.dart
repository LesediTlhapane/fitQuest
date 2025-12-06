// lib/views/fitquest_app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme.dart';
import 'home_screen.dart';
import 'plans_screen.dart';
import 'run_screen.dart';
import 'club_screen.dart';
import 'activity_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

import '../widgets/bottom_nav.dart';

import '../viewmodels/auth_vm.dart';
import '../viewmodels/run_vm.dart';
import '../services/firebase_service.dart';

class FitQuestApp extends StatefulWidget {
  static final GlobalKey<_FitQuestAppState> fitQuestKey =
      GlobalKey<_FitQuestAppState>();

  FitQuestApp() : super(key: fitQuestKey);

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

  void setCurrentIndex(int index) => setState(() => _currentIndex = index);

  Widget _mainApp() {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          PlansScreen(),
          RunScreen(),
          ClubScreen(),
          ActivityScreen(),
        ],
      ),
      bottomNavigationBar: FitQuestBottomNav(
        index: _currentIndex,
        onTap: setCurrentIndex,
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
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
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

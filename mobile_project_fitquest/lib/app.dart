import 'package:fitquest/main.dart';
import 'package:fitquest/services/auth_service.dart';
import 'package:fitquest/views/fitquest_app.dart';
import 'package:fitquest/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'viewmodels/auth_vm.dart';
import 'viewmodels/run_vm.dart';
import 'services/firebase_service.dart';
import 'fitquest_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(FirebaseService() as AuthService)),
        ChangeNotifierProvider(create: (_) => RunViewModel()),
      ],
      child: MaterialApp(
        title: 'FitQuest',
        theme: fitQuestTheme,
        debugShowCheckedModeBanner: false,
        home: const FitQuestApp(),
        routes: {
          '/signup': (_) => const SignUpScreen(),
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'firebase_options.dart';

// ViewModels
import 'viewmodels/auth_vm.dart';
import 'viewmodels/run_vm.dart';

// Services
import 'services/auth_service.dart';
import 'services/firebase_service.dart';
import 'services/sync_service.dart';

// Views
import 'views/welcome_screen.dart';
import 'views/login_screen.dart';
import 'views/signup_screen.dart';
import 'views/main_navigation_screen.dart';
import 'views/profile_screen.dart';
import 'views/home_screen.dart';

// Create a global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  
  // Initialize connectivity listener
  final connectivity = Connectivity();
  connectivity.onConnectivityChanged.listen((result) {
    if (result != ConnectivityResult.none) {
      print('Connection restored, triggering sync...');
      // We'll handle the actual sync when the app has a context
    }
  });
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<FirebaseService>(
          create: (_) => FirebaseService(),
        ),
        Provider<SyncService>(
          create: (context) => SyncService(
            Provider.of<AuthService>(context, listen: false),
            Provider.of<FirebaseService>(context, listen: false),
          ),
        ),
        
        // ViewModels
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(
            Provider.of<AuthService>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<RunViewModel>(
          create: (context) {
            final vm = RunViewModel();
            // Inject sync service after widget is built
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final syncService = Provider.of<SyncService>(context, listen: false);
              vm.setSyncService(syncService);
              vm.loadLocalRuns();
            });
            return vm;
          },
        ),
      ],
      child: MaterialApp(
        title: 'FitQuest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          useMaterial3: true,
        ),
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthWrapper(),
          '/welcome': (context) => const WelcomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/main': (context) => const MainNavigationScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/home': (context) => const HomeScreenEnhanced()
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
      return const MainNavigationScreen();
    }

    return const WelcomeScreen();
  }
}
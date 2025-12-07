import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitquest/views/welcome_screen.dart';
import 'package:fitquest/views/login_screen.dart';
import 'package:fitquest/views/signup_screen.dart';

void main() {
  testWidgets('WelcomeScreen has title and buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    // Verify title exists
    expect(find.text('FitQuest'), findsOneWidget);
    
    // Verify subtitle exists
    expect(find.text('Your Fitness Journey Awaits'), findsOneWidget);
    
    // Verify buttons exist
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('I already have an account'), findsOneWidget);
  });

  testWidgets('LoginScreen has form fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify form fields exist
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);
  });

  testWidgets('SignUpScreen has form fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpScreen()));

    // Verify form fields exist
    expect(find.byType(TextFormField), findsAtLeastNWidgets(4));
    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });

  testWidgets('TextField accepts input', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Test Field'),
            ),
          ],
        ),
      ),
    ));

    // Find the text field
    final textField = find.byType(TextFormField);
    
    // Enter text
    await tester.enterText(textField, 'Hello World');
    await tester.pump();

    // Verify text was entered
    expect(find.text('Hello World'), findsOneWidget);
  });

  testWidgets('Button tap triggers action', (WidgetTester tester) async {
    bool buttonPressed = false;
    
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              buttonPressed = true;
            },
            child: const Text('Test Button'),
          ),
        ),
      ),
    ));

    // Find and tap the button
    final button = find.text('Test Button');
    await tester.tap(button);
    await tester.pump();

    // Verify button was pressed
    expect(buttonPressed, isTrue);
  });
}
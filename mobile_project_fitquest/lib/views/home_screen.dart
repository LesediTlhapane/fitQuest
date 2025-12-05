import 'package:flutter/material.dart';
import 'fitquest_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(2),
              child: const Text("Go to Run"),
            ),
            ElevatedButton(
              onPressed: () => FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(3),
              child: const Text("Go to Club"),
            ),
          ],
        ),
      ),
    );
  }
}

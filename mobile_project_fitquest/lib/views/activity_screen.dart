import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_vm.dart';
import 'fitquest_app.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async => await auth.logout(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Activity Screen", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Go to Home tab
                FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(0);
              },
              child: const Text("Back to Home"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Go to Plans tab
                FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(1);
              },
              child: const Text("Go to Plans"),
            ),
          ],
        ),
      ),
    );
  }
}

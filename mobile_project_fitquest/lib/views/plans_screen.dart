import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_vm.dart';
import 'fitquest_app.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Plans"),
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
            const Text("Plans Screen", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Go to Run tab
                FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(2);
              },
              child: const Text("Start Run"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Go to Club tab
                FitQuestApp.fitQuestKey.currentState?.setCurrentIndex(3);
              },
              child: const Text("Go to Club"),
            ),
          ],
        ),
      ),
    );
  }
}

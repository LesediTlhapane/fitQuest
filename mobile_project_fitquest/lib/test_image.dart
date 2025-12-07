import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Test Image')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Testing Image Load...'),
              const SizedBox(height: 20),
              // Try to load the image
              Image.asset(
                'assets/Image.jpg',
                width: 300,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 50),
                      Text('Error: $error', style: const TextStyle(color: Colors.red)),
                      ElevatedButton(
                        onPressed: () {
                          print('Current directory:');
                        },
                        child: const Text('Debug'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
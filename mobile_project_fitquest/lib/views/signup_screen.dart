import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_vm.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            if (error != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(error!, style: const TextStyle(color: Colors.red))),
            const SizedBox(height: 20),
            loading ? const CircularProgressIndicator() : ElevatedButton(
              onPressed: () async {
                setState(() { loading = true; error = null; });
                final auth = Provider.of<AuthViewModel>(context, listen: false);
                final err = await auth.register(emailController.text.trim(), passwordController.text.trim());
                setState(() { loading = false; error = err; });
                if (err == null) Navigator.pop(context);
              },
              child: const Text("Create Account"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_vm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  String? error;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [

              Text("FitQuest",
                style: Theme.of(context).textTheme.titleLarge),

              const SizedBox(height: 40),

              _inputField(email, "Email", Icons.email_outlined),
              const SizedBox(height: 16),
              _inputField(password, "Password", Icons.lock_outline,
                  isPassword: true),

              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(error!,
                    style: const TextStyle(color: Colors.red)),
                ),

              const SizedBox(height: 20),

              loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        setState(() { loading = true; error = null; });

                        try {
                          await auth.login(
                            email.text.trim(),
                            password.text.trim(),
                          );

                          setState(() { 
                            loading = false; 
                            error = null; 
                          });
                        } catch (e) {
                          setState(() { 
                            loading = false; 
                            error = "Login failed. Please try again."; 
                          });
                        }
                      },
                      child: const Text("Login"),
                    ),

              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: const Text("Create an account"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String label,
      IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

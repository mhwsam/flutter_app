import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/utils/auth.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo 1
              Image.asset(
                'assets/images/samsung.png', // Replace with the path to your first logo
                width: 188, // Adjust the width as needed
                height: 51, // Adjust the height as needed
              ),
              // Logo 2
              Image.asset(
                'assets/images/fair_electronics.png', // Replace with the path to your second logo
                width: 160, // Adjust the width as needed
                height: 45, // Adjust the height as needed
              ),

              const SizedBox(height: 20),
              // Text "Login"
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 36, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7),
                ),
              ),
              const SizedBox(height: 8),
              // Email Input
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 8),
              // Password Input
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true, // Hide password characters.
              ),
              const SizedBox(height: 24),

              // Login Button

              ElevatedButton(
                onPressed: () async {
                  // Handle login logic here.
                  // Navigator.pushReplacementNamed(context, '/home'); // Replace with actual login logic.
                  // Get the user-entered email and password from the text fields.
                  final email =
                      emailController.text; // Replace with user-entered email
                  final password = passwordController
                      .text; // Replace with user-entered password
                  print('Email: $email');
                  print('Password: $password');
                  // Call the login method from the authProvider.
                  final loginSuccessful =
                      await authProvider.login(email, password);
                  if (loginSuccessful) {
                    // Navigate to the home screen after successful login.
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // Handle login failure.
                    // Show an error message or display a snackbar.
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Login failed. Please check your credentials.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Set the background color to black
                ),
                child: const Text('Login'),
              ),

              const SizedBox(height: 8), // Small gap
              // Forgot Password Link
              TextButton(
                onPressed: () {
                  // Handle forgot password logic here.
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

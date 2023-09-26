import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ), 
              const SizedBox(height: 8),
              // Password Input
              const TextField(
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
                onPressed: () {
                  // Handle login logic here.
                  // Navigator.pushReplacementNamed(context, '/home'); // Replace with actual login logic.
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
                
                child: const Text('Forgot Password?',
                style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay of 4 seconds and then navigate to the login screen.
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buro BD'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome.png'), // Replace with your image path
            fit: BoxFit.cover, // You can choose different BoxFit values based on your design
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Replace the logo with text "Welcome"
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 32, // You can adjust the font size
                  fontWeight: FontWeight.bold, // You can adjust the font weight
                  color: Color(0xFF767676), // You can adjust the text color
                ),
              ),
              SizedBox(height: 2), // Small gap
                  // Text below "Welcome"
                  Text(
                    'Unlock Your Business Potential with FairElectronics SME',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF767676), // Text color
                    ),
                    textAlign: TextAlign.center, // Center the text
                  ),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

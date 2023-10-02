import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/screens/splash_screen.dart';
import 'package:burobd/screens/login_screen.dart';
import 'package:burobd/screens/home_screen.dart';
import 'package:burobd/screens/categories/mobile_page.dart'; 
import 'package:burobd/screens/categories/tv_page.dart'; // Import the TVPage
import 'package:burobd/screens/categories/refrigerator_page.dart';
import 'package:burobd/screens/categories/washingmachine_page.dart';
import 'package:burobd/utils/auth.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'burobd', // Set the app title to 'burobd'.
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/mobile': (context) => MobilePage(), // Add the route to MobilePage
        '/tv': (context) => TVPage(), // Add the route to TVPage
        '/refrigerator': (context) => RefrigeratorPage(),
        '/washingmachine': (context) => WashingMachinePage(),
      },
    );
  }
}
       
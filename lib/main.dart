import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/screens/splash_screen.dart';
import 'package:burobd/screens/login_screen.dart';
import 'package:burobd/screens/home_screen.dart';
import 'package:burobd/screens/categories/mobile_page.dart';
import 'package:burobd/screens/categories/tv_page.dart'; // Import the TVPage
import 'package:burobd/screens/categories/refrigerator_page.dart';
import 'package:burobd/screens/categories/washingmachine_page.dart';
import 'package:burobd/screens/checkout_page.dart';
import 'package:burobd/utils/auth.dart';
import 'package:burobd/utils/ProductProvider.dart';
import 'package:burobd/utils/CartProvider.dart';
import 'package:burobd/screens/cart_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
            create: (context) => ProductProvider()), // Add ProductProvider here
        ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'burobd', // Set the app title to 'burobd'.
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/mobile': (context) =>
            const MobilePage(), // Add the route to MobilePage
        '/tv': (context) => const TVPage(), // Add the route to TVPage
        '/refrigerator': (context) => const RefrigeratorPage(),
        '/washingmachine': (context) => const WashingMachinePage(),
        '/checkout': (context) => CheckoutPage(),
        '/cart': (context) => CartPage(),
      },
    );
  }
}

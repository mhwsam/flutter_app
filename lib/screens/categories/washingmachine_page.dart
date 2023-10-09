import 'package:flutter/material.dart';

class WashingMachinePage extends StatelessWidget {
  const WashingMachinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Washing Machines'),
      ),
      body: const Center(
        child: Text('This is the Washing Machine Page content.'),
      ),
    );
  }
}

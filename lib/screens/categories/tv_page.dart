import 'package:flutter/material.dart';

class TVPage extends StatelessWidget {
  const TVPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Televisions'),
      ),
      body: const Center(
        child: Text('This is the TV Page content.'),
      ),
    );
  }
}
